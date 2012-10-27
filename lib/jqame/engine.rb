require 'bootstrap-sass'
require 'font-awesome-sass-rails'

module Jqame
  class Engine < ::Rails::Engine
    isolate_namespace Jqame

    config.generators do |g|
      g.test_framework :rspec, view_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
