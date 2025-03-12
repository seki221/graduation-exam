# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
# gem 'rails', '~> 6.1.4'
gem 'rails', '~> 7.0.8'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

gem 'bootsnap', '>= 1.4.4', require: false
# gem 'bootstrap-modal-rails'
# gem 'sidekiq'
gem 'country_select'
gem 'simple_form'
# gem 'mini_magick'
# gem 'ssrf_filter', '~> 1.2'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'carrierwave', '~> 3.0'

# Use Sass to process CSS
gem 'sassc-rails'
# gem "dartsass-rails", "~> 0.4.0"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'bootstrap5-kaminari-views'
gem 'image_processing', '~> 1.2'
gem 'kaminari'
gem 'ransack'

gem 'rails-i18n', '~> 7.0.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # gem 'factory_bot_rails'
  # gem 'minitest', '~> 5.25'
  gem 'rdoc', '~> 6.8'
  gem 'rspec-rails'
  gem 'pry-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'letter_opener_web'
  gem 'listen', '~> 3.3'
  gem 'web-console'

  gem 'fullcalendar-rails'

  gem 'faker'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  # gem "selenium-webdriver"
end

gem 'pg', group: :production
group :development, :test, :production do
  gem 'devise'
end
# gem "webpacker", "~> 5.4"

gem 'dotenv-rails'
gem 'geocoder'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'rails_admin'

gem 'rubocop', require: false
gem 'rubocop-rails', require: false 