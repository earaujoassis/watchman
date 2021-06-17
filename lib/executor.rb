# frozen_string_literal: true

require "logger"

module Executor
  module Backdoor; end

  module Commands; end

  module Helpers; end

  class << self
    def setup!
      root = File.expand_path("../../", __FILE__)
      Dir.glob(File.join(root, "lib", "executor", "**", "*.rb")).each { |f| require f }
      # change to working directory
      self
    end

    def start!
    end

    def tick!
      self.logger.info("Starting a new tick!")
      self.setup!.start!
    end

    def logger
      @logger ||= begin
        $stdout.sync = true
        logger = Logger.new(STDOUT)
        logger.level = Logger::INFO
        logger
      end
      @logger
    end

    def retrieve_communicator
      @communicator ||= begin

      end
    end
  end
end
