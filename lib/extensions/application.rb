require 'mono_logger'

module Backdoor
  class Application < Sinatra::Application
    register Backdoor::Extensions::API

    def logger
      Backdoor::Logger.instance
    end

    def config key
      Backdoor::Config.for key
    end

    error Sinatra::NotFound do
      status 404
      json error: {
        type: 'unknown resource',
        message: 'you came to nowhere, baby'
      }
    end

    error RuntimeError, Exception do
      status 500
      json error: {
        type: 'something unexpected',
        message: env['sinatra.error'].message
      }
    end
  end
end
