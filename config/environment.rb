require "bundler/setup"
require "hanami/setup"
require "hanami/model"
require "hanami/model/sql"
require "faye/websocket"
require "permessage_deflate"
require "json"
require_relative "../lib/backdoor"
require_relative "../apps/web/application"
require_relative "../apps/api/application"

Sequel.split_symbols = true

Hanami.configure do
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
    adapter :sql, ENV.fetch("DATABASE_URL")

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
    logger level: :info, formatter: :json, filter: []

    # mailer do
    #  delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    # end
  end
end
