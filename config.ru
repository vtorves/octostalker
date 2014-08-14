require './octostalker'

use Rack::Cache, {
  verbose: false,
  metastore: "memcached://#{ENV['MEMCACHE_PORT_11211_TCP_ADDR']}:11211/octostalker/meta",
  entitystore: "memcached://#{ENV['MEMCACHE_PORT_11211_TCP_ADDR']}:11211/octostalker/body"
}
use Rack::GoogleAnalytics, tracker: 'UA-46349409-1'

map OctostalkerApplication.assets_prefix do
  run OctostalkerApplication.assets
end

map '/' do
  run OctostalkerApplication
end
