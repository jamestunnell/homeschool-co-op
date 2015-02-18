source 'https://rubygems.org'

gem 'rails', '4.2.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Needed for bootstrap
gem 'therubyracer', platforms: :ruby
# LESS for stylesheets, and bootstrap for styling
gem 'less-rails-bootstrap'
# Adds nice generators and helpers for bootstrap
gem 'twitter-bootstrap-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Adss convenient form DSL
gem 'simple_form'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'mail_form' # email/contact form
gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun' # send emails using Mailgun API
gem 'devise' # Authenticate models with devise
gem 'carrierwave' # file upload integration
gem 'cloudinary' # cloud file storage service API
gem 'phony_rails' # validate phone numbers
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  # Better error handling gems
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

