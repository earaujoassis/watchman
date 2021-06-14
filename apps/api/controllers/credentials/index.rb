module Api
  module Controllers
    module Credentials
      class Index
        include Api::Action

        def call(params)
          self.format = :json

          repository = UserRepository.new
          user = repository.find_with_credentials(params[:id])
          halt 404, { error: "unknown user" } if user.nil?

          self.body = { user: { credentials: user.credentials.map(&:serialize) } }.to_json
        end
      end
    end
  end
end
