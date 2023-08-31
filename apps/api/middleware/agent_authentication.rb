# frozen_string_literal: true

module Api
  module AgentAuthentication
    def self.included(action)
      action.class_eval do
        before :authenticate!
      end
    end

    private

    def authenticate!
      authentication = Backdoor::Services::AgentAuthentication.new(request.env)
      unless authentication.authentic_client?
        halt 401, { error: "Invalid client credentials" }
      end
    end
  end
end
