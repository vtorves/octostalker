require './octofollow_app'

use Rack::Cache, verbose: false

map OctoFollowApplication.assets_prefix do
  run OctoFollowApplication.assets
end

map '/' do
  run OctoFollowApplication
end
