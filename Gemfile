source 'https://rubygems.org'
ruby "~> 2.4.4"


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.9'
gem 'mongoid'
gem 'bson_ext'
gem 'mongoid_auto_increment_id', "0.7.0"            #To avoid using ObjectID by default
gem "rmagick"
gem 'carrierwave', '~> 0.11.2'
gem "carrierwave-mongoid", :require => 'carrierwave'
gem 'bootstrap-sass', '~> 3.2.0'
#gem 'bootstrap', '~> 4.1.3'
gem 'sprockets-rails', '~> 3.0', '>= 3.0.4'
gem 'autoprefixer-rails'
#gem 'snackbarjs-rails', '~> 1.0'
gem 'sass-rails', '>= 3.2'

#for pagination
gem "will_paginate_mongoid"

#For authentication
gem 'devise'

# #For mongdb aggregation similar syntax
# gem 'moped', :git => 'git://github.com/mongoid/moped.git'

#For authorisation    #gem 'cancancan'
gem 'pundit'
#Needed in modal
#gem 'popper_js'
gem 'jquery-rails'
#gem 'turbolinks'

#For easy search
#gem "searchlogic"

#For select box
gem "select2-rails"

#for speeding up links
gem 'turbolinks'
gem 'jquery-turbolinks'

#For spinner
gem 'spinjs-rails'

#For background processing
gem 'sidekiq'

#To check Sidekiq worker status
gem 'sidekiq-status'

#For importing Spreadsheet
#gem 'csv'
gem 'roo'                   #Provides compatibility with csv,xls,xl
gem "roo-xls"
#gem "spreadsheet", "0.9.0"

gem "better_errors"         #for good UI exception desription presentation
gem "binding_of_caller"

#For Code Optimization
gem 'rubocop', '~> 0.59.2', require: false

#gem 'mongoid_search'
#gem 'mongoid-pagination'
#gem 'will_paginate'
#gem 'kaminari'
#gem 'kaminari-mongoid'
#gem 'grape-kaminari', :github => 'joshmn/grape-kaminari'
# Use SCSS for stylesheets
#gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
#gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
#gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.6'
  gem 'faker'
  gem 'byebug'

  

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :production do
  #heroku suggested gems to prevent warnings
  #to enable all platform features
  gem 'rails_12factor', '~> 0.0.3'
end

