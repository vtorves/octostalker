require 'rubygems'
require 'bundler/setup'
Bundler.require

class OctoFollowApplication < Sinatra::Base
  set :root,          File.dirname(__FILE__)
  set :assets,        Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|scss).+/, /application.(css|js)$/ ]
  set :assets_prefix, '/assets'
  set :digest_assets, false
  set(:assets_path)   { File.join public_folder, assets_prefix }

  configure do
    # Setup Sprockets
    %w{javascripts stylesheets images font}.each do |type|
      assets.append_path "assets/#{type}"
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

  get '/' do
    if client
      client.organizations.each do |org|
        org.rels[:avatar].href
      end
      @organizations = client.organizations
    end

    haml :index, layout: :'layouts/application'
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
    client.organizations.map(&:login)
  end

  post '/organization.do' do
    content_type :json
    counter = 0
    org = params[:org]
    client.organization_members(org).each do |member|
      login = member.login
      unless client.follows?(login)
        if client.follow(login)
          p "Following #{login}"
          counter += 1
        end
      end
    end

    { followed: counter }.to_json
  end

  def client
    return nil unless session[:auth]
    @client ||= Octokit::Client.new(access_token: session[:auth][:token])
  end

  helpers do
    include Sprockets::Helpers

    def current_user
      session[:auth]
    end
  end
end
