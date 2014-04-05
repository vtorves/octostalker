require './octostalker'
require 'rake/sprocketstask'

Rake::SprocketsTask.new do |t|
  t.environment = OctostalkerApplication.assets
  t.output      = "./public/assets"
  t.assets      = OctostalkerApplication.precompile
end

if defined? RSpec
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new("spec") do |spec|
    spec.pattern = "spec/**/*_spec.rb"
  end
  task :default => :spec
end
