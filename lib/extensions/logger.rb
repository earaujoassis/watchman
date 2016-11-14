require 'singleton'
require 'mono_logger'

module Backdoor
  class Logger
    include Singleton

    def initialize
      @_logger = MonoLogger.new('log/backdoor.log')
      @_logger.level = MonoLogger::INFO
      @_logger
    end

    private

    def method_missing method, *args, &block
      args[0] = "#{Time.now.inspect} #{args[0].to_s}" if args.length > 0
      @_logger.send method, *args, &block
    end
  end
end
