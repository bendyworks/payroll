require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'support/factory_bot'
require 'support/helpers'
require 'database_cleaner/active_record'

Capybara.server = :puma
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

module ViewHelpers
  def view_helper
    ViewHelper.instance
  end

  class ViewHelper
    include Singleton
    include ActionView::Helpers::NumberHelper
    include ApplicationHelper
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.before(:suite) do
    require "#{Rails.root}/db/seeds.rb"
  end
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Capybara::DSL
  config.include ViewHelpers
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end