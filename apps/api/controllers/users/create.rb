# frozen_string_literal: true

module Api
  module Controllers
    module Users
      class Create
        include Api::Action

        params Class.new(Hanami::Action::Params) {
          predicate(:minimum_size?, message: "doesn't have minimum size of #{User::PASSPHRASE_MINIMUM_SIZE}") do |current|
            current.length >= User::PASSPHRASE_MINIMUM_SIZE
          end

          validations do
            required(:user).schema do
              required(:email).filled(:str?, format?: /@/)
              required(:github_token).filled(:str?)
              required(:passphrase) { filled? & str? & minimum_size? }
            end
          end
        }

        def call(params)
          repository = UserRepository.new
          repository.create_master_user(params[:user])
          self.body = { user: repository.master_user.serialize }
        end
      end
    end
  end
end
