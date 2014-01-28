require './octostalker'

use Rack::Cache, {
  verbose: false,
  metastore: 'memcached://localhost:11211/meta',
  entitystore: 'memcached://localhost:11211/body'
}
use Rack::GoogleAnalytics, tracker: 'UA-46349409-1'

map OctostalkerApplication.assets_prefix do
  run OctostalkerApplication.assets
end

map '/' do
  run OctostalkerApplication
end
