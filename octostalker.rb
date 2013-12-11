require 'rubygems'
require 'bundler/setup'
Bundler.require

class OctostalkerApplication < Sinatra::Base
  set :root,          File.dirname(__FILE__)
  set :assets,        Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|scss).+/, /application.(css|js)$/ ]
  set :assets_prefix, '/assets'
  set :digest_assets, false
  set :assets_path,   File.join(root, assets_prefix)

  configure do
    # Setup Sprockets
    %w{javascripts stylesheets images font}.each do |type|
      assets.append_path "assets/#{type}"
    end

    Compass.configuration do |compass|
      compass.project_path = settings.assets_path
      compass.images_dir = 'images'
      compass.output_style = ':expanded'
      compass.relative_assets = true
    end

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder
      config.debug       = true
    end

    set :haml, { :format => :html5 }

    enable :sessions, :logging

    use OmniAuth::Builder do
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:follow"
    end
  end

  error 403 do
    {message:'Sorry, you have to login first.'}.to_json
  end

  get '/' do
    if client
      client.organizations.each do |org|
        org.rels[:avatar].href
      end
      @organizations = client.organizations
      @friends = client.followers(client.login, per_page: 16, auto_paginate: false)

      haml :logged, layout: :'layouts/application'
    else
      haml :index, layout: :'layouts/application'
    end
  end

  get '/auth/github/callback' do
    session[:auth] ||= {}
    auth = env['omniauth.auth']
    session[:auth][:uid] = auth['uid']
    session[:auth][:token] = auth['credentials']['token']
    session[:auth][:avatar] = auth[:extra][:raw_info][:avatar_url]
    redirect to('/')
  end

  post '/friends.do' do
    content_type :json
    client or (return 403)
    counter = follow_users client.followers
    {followed: counter}.to_json
  end

  post '/organization.do' do
    content_type :json
    client or (return 403)

    begin
      org = params[:org]
      counter = follow_users client.organization_members(org)
    rescue Octokit::NotFound
      status 404
      return {message: 'Organization not found'}.to_json
    end
    {followed: counter}.to_json
  end

  post '/me.do' do
    content_type :json
    client or (return 403)
    {success: client.follow('arthurnn')}.to_json
  end

  def client
    return nil unless session[:auth]
    @client ||= Octokit::Client.new(access_token: session[:auth][:token])
  end

  def follow_users(users)
    counter = 0
    users.each do |member|
      login = member.login
      next if login == client.login
      if !client.follows?(login) && client.follow(login)
        counter += 1
      end
    end
    counter
  end

  helpers do
    include Sprockets::Helpers

    def current_user
      session[:auth]
    end
  end
end
