source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami'
gem 'hanami-model'
gem 'pg'
gem 'concurrent-ruby', require: 'concurrent'
gem 'concurrent-ruby-ext'
gem 'faye-websocket'
gem 'permessage_deflate'
gem 'foreman'
gem 'puma'
gem 'octokit', '~> 4.0'

# Watchman
gem 'whois'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/applications/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'rspec'
  gem 'coveralls', require: false
end

group :production do
end
