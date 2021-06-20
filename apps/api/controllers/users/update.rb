# frozen_string_literal: true

module Api
  module Controllers
    module Users
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
          repository = UserRepository.new
          user = repository.find!(params[:id])
          unless user.passphrase_match?(params[:user][:passphrase_confirmation])
            halt 401, { error: "wrong passphrase" }
          end

          repository.update_user(params[:id], params[:user].slice(:github_token))
          self.body = { user: repository.master_user.serialize }
        rescue Backdoor::Errors::UndefinedEntity
          self.body = { user: nil }
        end
      end
    end
  end
end
