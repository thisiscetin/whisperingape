source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "selenium-webdriver"
gem "webdrivers"
gem "sidekiq", "~> 6.0"
gem "redis", "~> 4.8"
gem "neighbor"
gem "ruby-openai"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-performance", require: false
  gem "brakeman", require: false
end

group :development do
  gem "guard", require: false
  gem "guard-rspec", require: false
  gem "guard-rubocop", require: false
end

group :test do
  gem "factory_bot_rails"
end

