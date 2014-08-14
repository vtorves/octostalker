require './octostalker'

use Rack::Cache, {
  verbose: false,
  metastore: "memcached://#{ENV['MEMCACHE_SERVERS']}/octostalker/meta",
  entitystore: "memcached://#{ENV['MEMCACHE_SERVERS']}/octostalker/body"
}
use Rack::GoogleAnalytics, tracker: 'UA-46349409-1'

map OctostalkerApplication.assets_prefix do
  run OctostalkerApplication.assets
end

map '/' do
  run OctostalkerApplication
end
