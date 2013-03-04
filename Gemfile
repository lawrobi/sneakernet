source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'omniauth'
gem "omniauth-facebook"
gem 'omniauth-linkedin'
gem 'koala'
gem 'devise'
gem "haml-rails"
gem "geocoder"

# Gems used only for assets and not required
# in production environments by default.
group :development do
  gem 'sqlite3'
end
group :assets do
  gem "select2-rails"
  gem 'sass-rails',   '~> 3.2.3'
  gem "rails-backbone" # lest back bone that shit
  gem 'handlebars_assets' # More info here https://github.com/leshill/handlebars_assets
  gem 'hamlbars'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation', '~> 4.0.0'
  gem 'pry'
  gem 'pry-nav'
end

gem 'jquery-rails'
group :production do
  gem 'pg'
end

group :development, :test do
  gem "rspec-rails"
  gem 'factory_girl_rails'
  gem 'faker'
end
