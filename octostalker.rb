require 'rubygems'
require 'bundler/setup'
Bundler.require
require './octokit_ext'

class OctostalkerApplication < Sinatra::Base
  MEMCACHED_ADDR = ENV['MEMCACHED_URL'] || "localhost:11211"

  set :root, File.dirname(__FILE__)
  set :assets, Sprockets::Environment.new(root)
  set :precompile, [ /\w+\.(?!js|scss).+/, /application.(css|js)$/ ]
  set :assets_prefix, '/assets'
  set :assets_path, File.join(root, assets_prefix)

  set :partial_template_engine, :haml
  set :haml, { format: :html5 }
  set :server, :puma
  enable :logging
  register Sinatra::Partial

  # Use the Dalli Rack session implementation
  use Rack::Session::Dalli, cache: Dalli::Client.new(MEMCACHED_ADDR,
    compress: true,
    namespace: 'octostalker/rack.session',
    expires_in: 3600)
  use Rack::Flash

  configure(:test) { disable :logging }

  configure do
    %w{javascripts stylesheets images font}.each do |type|
      assets.append_path "assets/#{type}"
    end

    Compass.configuration do |compass|
      compass.project_path = settings.assets_path
      compass.images_dir = 'images'
      compass.output_style = ':expanded'
      compass.relative_assets = true
    end

    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = assets_prefix
      config.digest      = true
      config.public_path = public_folder
    end

    use OmniAuth::Builder do
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"
    end
  end

  error 403 do
    {message:'Sorry, you have to login first.'}.to_json
  end

  get '/' do
    if client
      @organizations = cache.fetch("index/#{current_user[:uid]}/organizations", 36000) do
        if orgs = client.organizations
          orgs.map { |o| organization_hash(o) }
        end
      end

      @friends = client.followers(client.login, per_page: 16, auto_paginate: false)
      @friends.map!{ |u| user_hash(u) }
      haml :logged, layout: :'layouts/application'
    else
      haml :index, layout: :'layouts/application'
    end
  end

  get '/logout' do
    session.clear
    redirect to('/')
  end

  get '/auth/github/callback' do
    session[:auth] ||= {}
    auth = env['omniauth.auth']
    session[:auth][:uid] = auth['uid']
    session[:auth][:token] = auth['credentials']['token']
    avatar = auth[:extra][:raw_info][:avatar_url]
    avatar = avatar + "&s=400" if avatar =~ /.gravatar.com/
    session[:auth][:avatar] = avatar
    redirect to('/')
  end

  get '/auth/failure' do
    flash[:notice] = params[:message]
    redirect '/'
  end

  post '/friends.do' do
    content_type :json
    client or (return 403)
    follow_users client.followers
    {success: true}.to_json
  end

  get '/organization/:org' do
    client or (return 403)

    cache_control :public, :max_age => 36000
    org = params[:org]
    begin
      org = client.org(org)
    rescue Octokit::NotFound
      status 404
      return
    end
    partial :organization, locals: {
      organization: organization_hash(org)
    }
  end

  post '/organization.do' do
    content_type :json
    client or (return 403)

    begin
      org = params[:org]
      follow_users client.organization_members(org)
    rescue Octokit::NotFound
      status 404
      return {message: 'Organization not found'}.to_json
    end
    {success: true}.to_json
  end

  error Octokit::Unauthorized do
    session.clear
    redirect to('/')
  end

  helpers do
    include Sprockets::Helpers

    def current_user
      session[:auth]
    end
  end

  private

  def organization_hash(org, load_members = true)
    avatar = org.rels[:avatar].href
    avatar = avatar + "&s=400" if avatar =~ /.gravatar.com/
    size, members = nil, []

    if load_members
      members = client.organization_members(org.login, per_page: 16, auto_paginate: false)
      members.map!{ |u| user_hash(u) }
      size = client.organization_members_size(org.login)
    end

    { avatar: avatar,
      login: org.login,
      members: members,
      size: size
    }
  end

  def user_hash(user)
    {
      avatar: user.rels[:avatar].href,
      follows: false,
      login: user.login,
      url: "http://www.github.com/#{user.login}",
    }
  end

  def client
    return nil unless session[:auth]
    @client ||= Octokit::Client.new(access_token: session[:auth][:token])
  end

  def follow_users(users)
    users.each do |member|
      login = member.login
      next if login == client.login
      client.follow(login)
    end
  end

  def cache
    @cache ||= Dalli::Client.new(MEMCACHED_ADDR, compress: true, namespace: 'octostalker')
  end

end
