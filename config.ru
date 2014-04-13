require './octostalker'

use Rack::GoogleAnalytics, tracker: 'UA-46349409-1'

map OctostalkerApplication.assets_prefix do
  run OctostalkerApplication.assets
end

map '/' do
  run OctostalkerApplication
end
