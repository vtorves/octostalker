require './octostalker'

use Rack::Cache, verbose: false

map OctostalkerApplication.assets_prefix do
  run OctostalkerApplication.assets
end

map '/' do
  run OctostalkerApplication
end
