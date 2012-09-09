require 'rubygems'
require 'spork'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)

  require 'factory_girl'
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

Spork.each_run do
  #FactoryGirl.reload
  # This code will be run each time you run your specs.

end


# This file is copied to spec/ when you run 'rails generate rspec:install'
#require 'rspec/rails'
#require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

RSpec.configure do |config|
  # Adding focus filter to RSpec so we can choose the spec that 
  # will be run (see http://asciicasts.com/episodes/285-spork)
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
