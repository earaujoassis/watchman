# frozen_string_literal: true

module Api::Controllers::Users
  class Create
    include Api::Action
    include Api::UserAuthentication

    params Class.new(Hanami::Action::Params) {
      predicate(:minimum_size?, message: "doesn't have minimum size of #{User::PASSPHRASE_MINIMUM_SIZE}") do |current|
        current.length >= User::PASSPHRASE_MINIMUM_SIZE
      end

      validations do
        required(:user).schema do
          required(:github_token).filled(:str?)
          required(:passphrase) { filled? & str? & minimum_size? }
          optional(:git_commit_email).filled(:str?)
        end
      end
    }

    def call(params)
      user = Backdoor::Commands::UserCompleteCreateCommand.new(params: params[:user]).perform
      self.body = { user: user.serialize }
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
