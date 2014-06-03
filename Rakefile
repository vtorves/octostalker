require './octostalker'
require 'rake/sprocketstask'

Rake::SprocketsTask.new do |t|
  t.environment = OctostalkerApplication.assets
  t.output      = "./public/assets"
  t.assets      = OctostalkerApplication.precompile
end

