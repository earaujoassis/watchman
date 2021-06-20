# frozen_string_literal: true

module Api
  module Controllers
    module Credentials
      class Inactivate
        include Api::Action

        params do
          required(:user_id).filled(:str?)

          required(:credential_id).filled(:str?)
        end

        def call(params)
          user_repository = UserRepository.new
          user = user_repository.find(params[:user_id])
          halt 404, { error: "unknown user" } if user.nil?
          credential = user_repository.owned_credential(params[:user_id], params[:credential_id])
          halt 404, { error: "unknown credential" } if credential.nil?

          credential_repository = CredentialRepository.new
          credential_repository.inactivate(user, credential)

          user = user_repository.find_with_credentials(params[:user_id])
          self.body = { user: { credentials: user.credentials.map(&:serialize) } }
        end
      end
    end
  end
end
