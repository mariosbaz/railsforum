
source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

# Use postgresql as the database for Active Record
gem 'pg'

# Use to include bootstrap
gem 'bootstrap-sass', '~> 3.2.0'

# Use gems for pagination
gem 'will_paginate', '3.0.4'
gem 'will_paginate-bootstrap', '~> 1.0.1'

# Use for User authentication
gem 'devise'

# Paperclip fir orofile photos
gem "paperclip", "~> 4.2"
gem 'aws-sdk'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

group :production do
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
  gem 'rails_12factor', '0.0.2'
end

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#gems for testing
group :development, :test do 
  gem 'rspec-rails', "~> 2.14.0"
  gem 'foreman'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '~> 2.4.3'
  gem 'factory_girl_rails', '4.2.0'
  gem 'faker', '~> 1.1.2'
end

