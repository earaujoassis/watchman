# frozen_string_literal: true

module Api
  module UserAuthentication
    def self.included(action)
      action.class_eval do
        before :authenticate!
      end
    end

    private

    def authenticate!
      authentication = Backdoor::Services::UserAuthentication.new(session)
      unless authentication.authentic_user?
        halt 401, { error: "Unauthorized user request" }
      end
    end
  end
end
