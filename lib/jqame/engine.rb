module Jqame
  class Engine < ::Rails::Engine
    isolate_namespace Jqame

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
  end
end
