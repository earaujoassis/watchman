require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_storage/engine"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module Watchman
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks web])

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc

    # config.eager_load_paths << Rails.root.join("extras")

    config.api_only = true
  end
end
