source 'https://rubygems.org'
gem 'rails', '4.0.3'
gem 'rack-contrib'

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
end


gem 'devise'
gem 'cancan'
gem 'rolify'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-vkontakte'

gem 'russian'

gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.1.1'
gem "haml", ">= 3.1.6"
gem 'haml-rails'
gem 'formtastic-bootstrap'
gem "draper"
gem 'turbolinks'

gem "mongoid", github: "mongoid/mongoid"
gem 'mongoid-versioning', github: 'simi/mongoid-versioning'
gem 'bson_ext'

gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
group :production do
  gem 'unicorn'
end


# Use Capistrano for deployment
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'

  gem 'quiet_assets'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'thin'

  gem "erb2haml"
end


# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'newrelic_rpm'