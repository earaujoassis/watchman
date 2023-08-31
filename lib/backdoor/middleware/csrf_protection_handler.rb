module Backdoor::Middleware
  module CSRFProtectionHandler
    def self.included(action)
      action.class_eval do
        # Do nothing
      end
    end

    private

    def handle_invalid_csrf_token
      # Do nothing
    end

    def verify_csrf_token?
      false
    end
  end
end
