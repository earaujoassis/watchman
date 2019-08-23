source "https://rubygems.org"

gem "bundler"
gem "concurrent-ruby", require: "concurrent"
gem "concurrent-ruby-ext"
gem "faye-websocket"
gem "foreman"
gem "hanami"
gem "hanami-model"
gem "hanami-utils"
gem "octokit", "~> 4.0"
gem "permessage_deflate"
gem "pg"
gem "puma"
gem "rake"

# Watchman
gem "whois"

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
  gem "coveralls", require: false
  gem "minitest"
  gem "rspec"
end

group :production do
end
