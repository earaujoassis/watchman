# frozen_string_literal: true

require "bundler/setup"
require "hanami/setup"
require "hanami/model"
require "hanami/model/sql"
require "faye/websocket"
require "permessage_deflate"
require "json"
require "sentry-ruby"
require_relative "../lib/backdoor"
require_relative "../apps/web/application"
require_relative "../apps/api/application"
require_relative "../apps/executors/application"

Sequel.split_symbols = true

Hanami.configure do
  mount Executors::Application, at: "/api/executors"
  mount Api::Application, at: "/api"
  mount Web::Application, at: "/"

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'postgresql://localhost/backdoor_development'
    #
    adapter :sql, ENV.fetch("WATCHMAN_DATABASE_URL")

    ##
    # Migrations
    #
    migrations "db/migrations"
    schema     "db/schema.sql"
  end

  mailer do
    root "lib/backdoor/mailers"

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :test do
    logger level: :error, filter: []
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug, filter: []
  end

  environment :production do
    logger level: :info, filter: %w[passphrase passphrase_confirmation github_token code]

    if ENV.has_key?("WATCHMAN_SENTRY_URL")
      Sentry.init do |config|
        config.dsn = ENV.fetch("WATCHMAN_SENTRY_URL")
        config.transport.ssl_verification = false
        config.environment = ENV.fetch("HANAMI_ENV")
        config.release = "watchman@#{ENV.fetch("COMMIT_HASH")}"
        config.traces_sample_rate = 1.0
      end
    end

    # mailer do
    #  delivery :smtp, address: ENV.fetch('WATCHMAN_SMTP_HOST'), port: ENV.fetch('WATCHMAN_SMTP_PORT')
    # end
  end
end
