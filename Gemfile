# frozen_string_literal: true

source "https://rubygems.org"

gem "bcrypt"
gem "bundler"
gem "concurrent-ruby", require: "concurrent"
gem "concurrent-ruby-ext"
gem "dry-types"
gem "faye-websocket"
gem "foreman"
gem "git"
gem "hanami", "~> 1.3"
gem "hanami-model", "~> 1.3"
gem "hanami-utils"
gem "hanami-validations"
gem "oauth2"
gem "faraday", "~> 1.4"
gem "faraday_middleware", "~> 1.2"
gem "octokit", "~> 4.0"
gem "permessage_deflate"
gem "pg"
gem "puma"
gem "rack-protection", "~> 2.1"
gem "rake"
gem "rest-client"
gem "rufus-scheduler", "~> 3.6", require: false
gem "whois"
gem "yaml"

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/applications/code-reloading
  gem "hanami-webconsole"
  gem "rubocop", require: false
  gem "rubocop-github", require: false
  gem "shotgun", platforms: :ruby
end

group :test, :development do
  gem "dotenv", "~> 2.4"
end

group :test do
  gem "capybara"
  gem "codecov", "~> 0.5.2", require: false
  gem "coveralls", require: false
  gem "minitest"
  gem "rspec"
  gem "webmock", require: false
end

group :production do
  gem "sentry-ruby", "~> 5.10"
end
