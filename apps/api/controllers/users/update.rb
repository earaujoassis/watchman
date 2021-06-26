# frozen_string_literal: true

module Api::Controllers::Users
  class Update
    include Api::Action

    params do
      required(:id).filled(:str?)

      required(:user).schema do
        required(:github_token).filled(:str?)
        required(:passphrase_confirmation).filled(:str?)
      end
    end

    def call(params)
      user = Backdoor::Commands::UserUpdateCommand.new(params: params[:user], user_id: params[:id]).perform
      self.body = { user: user.serialize }
    rescue Backdoor::Errors::UndefinedEntity
      self.body = { user: nil }
    rescue Backdoor::Errors::PassphraseConfirmationError => e
      halt 401, { error: e.message }
    rescue Backdoor::Errors::CommandError => e
      halt 406, {
        error: {
          message: e.message,
          reasons: e.errors
        }
      }
    rescue Backdoor::Services::Security::Error => e
      halt 503, { error: e.message }
    end
  end
end
