$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jqame/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jqame"
  s.version     = Jqame::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Jqame."
  s.description = "TODO: Description of Jqame."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "spork-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "guard-spork"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "libnotify"
  s.add_development_dependency "rb-inotify"
end
