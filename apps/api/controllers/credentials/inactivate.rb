# frozen_string_literal: true

module Api::Controllers::Credentials
  class Inactivate
    include Api::Action
    include Api::UserAuthentication

    params do
      required(:user_id).filled(:str?)

      required(:credential_id).filled(:str?)
    end

    def call(params)
      user_repository = UserRepository.new
      user = user_repository.find!(params[:user_id])
      credential = user_repository.owned_credential!(params[:user_id], params[:credential_id])

      credential_repository = CredentialRepository.new
      credential_repository.inactivate(user, credential)

      user = user_repository.find_with_credentials(params[:user_id])
      self.body = { user: { credentials: user.credentials.map(&:serialize) } }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    end
  end
end
