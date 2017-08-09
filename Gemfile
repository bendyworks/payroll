# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.1'

gem 'airbrake'          # robust exception tracking
gem 'bootstrap-sass'    # SASS port of  Bootstrap 3
gem 'devise'            # Flexible authentication solution
gem 'devise_invitable'  # Invitation strategy for devise
gem 'google_visualr'    # Google Visualization API
gem 'haml'              # HTML Abstraction Markup Language
gem 'haml-rails'        # HAML generators
gem 'immigrant'         # Foreign key migration generator
gem 'puma'              # Ruby web server built for concurrency
gem 'smarter_csv'       # importing csv files as array(s) of hashes

gem 'best_in_place'     # in place editing
gem 'coffee-rails'      # CoffeeScript adapter
gem 'pg'                # PostgreSQL
gem 'rails'             # Ruby on Rails
gem 'sass-rails'        # Sass adapter
gem 'uglifier'          # minifies JavaScript, wraps UglifyJS

gem 'jbuilder'          # Create JSON structures
gem 'jquery-rails'      # jQuery and jQuery-ujs
gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'turbolinks'        # Faster link following

gem 'rake'              # Make-like program
gem 'rubocop', require: false # Automatic Ruby code style checking

group :development do
  gem 'rails-erd'       # Generate an entity-relationship diagram
  gem 'spring'          # Preloads your application
end

group :development, :test do
  gem 'pry'                     # IRB alternative and runtime dev console
  gem 'pry-byebug'              # combine pry with byebug
  gem 'rails_best_practices'
  gem 'rspec-rails'             # testing framework
end

group :test do
  gem 'capybara'                        # Integration testing tool
  gem 'cucumber-rails', require: false  # Automated acceptance tests
  gem 'database_cleaner'                # Strategies for cleaning databases
  gem 'factory_girl_rails'              # Setup Ruby objects as test data
  gem 'launchy'
  gem 'selenium-webdriver'              # Automated tests of websites
  gem 'shoulda-matchers'                # Collection of testing matchers
end

group :production do
  gem 'rails_12factor' # Run Rails the 12factor way
end

group :doc do
  gem 'sdoc' # rdoc generator
end
