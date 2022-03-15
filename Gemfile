# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.2'

gem 'bootstrap-sass'    # SASS port of  Bootstrap 3
gem 'devise'            # Flexible authentication solution
gem 'devise_invitable'  # Invitation strategy for devise
gem 'google_visualr', git: 'https://github.com/winston/google_visualr' # Google Visualization API
gem 'haml'              # HTML Abstraction Markup Language
gem 'haml-rails'        # HAML generators
gem 'immigrant'         # Foreign key migration generator
gem 'puma'              # Ruby web server built for concurrency
gem 'smarter_csv'       # importing csv files as array(s) of hashes

gem 'best_in_place', git: 'https://github.com/bendyworks/best_in_place' # in place editing
gem 'coffee-rails'      # CoffeeScript adapter
gem 'pg'                # PostgreSQL
gem 'rails', '6.1.4.6'  # Ruby on Rails
gem 'sass-rails'        # Sass adapter
gem 'uglifier'          # minifies JavaScript, wraps UglifyJS

gem 'jbuilder'          # Create JSON structures
gem 'jquery-rails'      # jQuery and jQuery-ujs
gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'turbolinks'        # Faster link following

gem 'rake'              # Make-like program
gem 'rubocop', require: false # Automatic Ruby code style checking
gem 'rubocop-performance', require: false # Rubocop extension for performance checks
gem 'rubocop-rails', require: false # Rubocop extension for Rails checks
gem 'rubocop-rake', require: false # Rubocop extension for Rake checks
gem 'rubocop-rspec', require: false # Rubocop extension for rspec checks

gem 'react-rails'
gem 'webpacker'

group :development do
  gem 'rails-erd'       # Generate an entity-relationship diagram
  gem 'spring'          # Preloads your application
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'rspec-rails', '5.1.0' # testing framework
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.20'
end

group :test do
  gem 'capybara', '~> 3.36'
  # gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'
end

group :doc do
  gem 'sdoc' # rdoc generator
end
