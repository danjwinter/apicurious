source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'omniauth-github'
gem 'figaro'
gem 'faraday'
gem 'nokogiri'
gem 'sidekiq'
gem 'launchy'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'simplecov', :require => false, :group => :test
gem 'sass-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'byebug'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'vcr'
  gem 'webmock', '~> 1.8.0'
end
