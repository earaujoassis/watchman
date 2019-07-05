module Api
  module Authentication
    def self.included(action)
      action.class_eval do
        before :authenticate!
      end
    end

    private

    def authenticate!
      authentication = Backdoor::Services::Authentication.new(request.env)
      unless authentication.authentic_client?
        halt 401, { error: "Invalid client credentials" }.to_json
      end
    end
  end
end
