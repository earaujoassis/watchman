source "https://rubygems.org"

gem "rails", "~> 8.0.2"

gem "pg", "~> 1.1"

gem "puma", ">= 5.0"

# [https://github.com/rails/jbuilder]
# gem "jbuilder"

gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false

# gem "image_processing", "~> 1.2"

gem "rack-cors"
gem "jwt"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false

  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "annotate"
end
