# frozen_string_literal: true

module Api
  module Controllers
    module Credentials
      class Inactivate
        include Api::Action

        def call(params)
          user_repository = UserRepository.new
          user = user_repository.find(params[:user_id])
          halt 404, { error: "unknown user" }.to_json if user.nil?
          credential = user_repository.owned_credential(params[:user_id], params[:credential_id])
          halt 404, { error: "unknown credential" }.to_json if credential.nil?

          credential_repository = CredentialRepository.new
          credential_repository.inactivate(user, credential)

          user = user_repository.find_with_credentials(params[:user_id])
          self.body = { user: { credentials: user.credentials.map(&:serialize) } }.to_json
        end
      end
    end
  end
end
