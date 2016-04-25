# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'

require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/rspec'
require 'capybara/rails'
require 'turnip/capybara' # for scopes

Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :webkit
Capybara::Webkit.configure do |config|
  config.block_unknown_urls
  config.allow_url("https://ajax.googleapis.com/ajax/static/modules/gviz/1.0/core/tooltip.css")
  config.allow_url("https://www.google.com/uds/api/visualization/1.0/69d4d6122bf8841d4832e052c2e3bf39/format+en,default+en,ui+en,corechart+en.I.js")
  config.allow_url("https://www.google.com/jsapi")
  config.allow_url("www.google.com")
  config.allow_url("https://www.google.com/uds/?file=visualization&v=1.0&packages=corechart&async=2")
  config.allow_url("fonts.googleapis.com")
  config.allow_url("http://fonts.googleapis.com/css?family=Lato:400,700,400italic")
end

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.include Capybara::DSL
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
