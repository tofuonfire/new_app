source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '6.0.0'
gem 'bootstrap'
gem 'devise'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'faker'
gem 'rails-i18n'
gem 'kaminari'
gem 'mysql2'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'bootsnap', require: false
gem 'ransack'
gem 'dotenv-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'guard-rspec', require: false
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'sshkit-sudo', require: false
  gem 'capistrano3-puma', require: false

  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
  gem 'letter_opener_web'
end

group :test do
  gem 'simplecov', require: false

  gem 'capybara'
  gem 'webdrivers'
  gem 'launchy'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
