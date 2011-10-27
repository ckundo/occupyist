source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'jquery-rails'
gem 'haml-rails'
gem 'rest-client', "~> 1.6.7"
gem 'bourbon'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :production do
  gem 'pg'
  gem 'execjs'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem "ZenTest"
  gem "autotest-growl"
  gem "minitest"
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :development do
  gem 'compass'
end
