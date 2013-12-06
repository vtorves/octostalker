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
  end

  before do
    expires 500, :public, :must_revalidate
  end

  get '/' do
    haml :index, layout: :'layouts/application'
  end

  helpers do
    include Sprockets::Helpers
  end
end
