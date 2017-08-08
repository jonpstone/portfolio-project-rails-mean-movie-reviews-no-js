
# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"



ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.default_selector = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


clear_assets = Proc.new do
  `bundle exec rake -f ./test/dummy/Rakefile assets:clobber`
  raise "could not clear assets" unless $?.success?
end

clear_assets.call