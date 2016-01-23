require './octostalker'

if memcached = ENV['MEMCACHE_PORT_11211_TCP_ADDR']
  use Rack::Cache, {
    verbose: false,
    metastore: "memcached://#{memcached}:11211/octostalker/meta",
    entitystore: "memcached://#{memcached}:11211/octostalker/body"
  }
end

map OctostalkerApplication.assets_prefix do
  run OctostalkerApplication.assets
end

map '/' do
  run OctostalkerApplication
end
