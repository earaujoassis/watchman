require "sentry-ruby"

module Backdoor::Middleware
  module ExceptionHandler
    def self.included(action)
      action.class_eval do
        handle_exception StandardError => :handle_standard_error
      end
    end

    private

    def handle_standard_error(exception)
      Sentry.capture_exception(exception)
      raise exception
      status 500, "Something went wrong handling your request"
    end
  end
end
