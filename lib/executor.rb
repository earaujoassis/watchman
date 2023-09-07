# frozen_string_literal: true

require "logger"
require "stackprof"
require "sentry-ruby"

module Executor
  module Backdoor; end

  module Commands; end

  module Core; end

  module Helpers; end

  class << self
    def setup!
      root = File.expand_path("../../", __FILE__)
      Dir.glob(File.join(root, "lib", "executor", "**", "*.rb")).each { |f| require f }
      if ENV.has_key?("EXECUTOR_SENTRY_URL")
        Sentry.init do |config|
          config.dsn = ENV.fetch("EXECUTOR_SENTRY_URL")
          config.transport.ssl_verification = false
          config.environment = ENV.fetch("EXECUTOR_ENV", "development")
          config.release = "executor@#{ENV.fetch("COMMIT_HASH")}"
          config.profiles_sample_rate = 1.0
          config.traces_sample_rate = 1.0
        end
      end
      # change to working directory
      self
    end

    def start!
      commands_identified = Hash.new
      commands = Executor::Commands.constants.select { |c| Executor::Commands.const_get(c).is_a? Class }
      commands.each do |command|
        identifier = Executor::Commands.const_get(command).const_get(:Identifier)
        commands_identified[identifier] = Executor::Commands.const_get(command)
      end
      Core.perform(commands_identified)
    end

    def tick!
      self.logger.info("Starting a new tick!")
      self.setup!.start!
    rescue StandardError => e
      Sentry.capture_exception(e)
    end

    def logger
      @logger ||= begin
        $stdout.sync = true
        logger = Logger.new(STDOUT)
        logger.level = Logger::WARN
        logger
      end
      @logger
    end
  end
end
