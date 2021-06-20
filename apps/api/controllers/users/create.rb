# frozen_string_literal: true

module Api
  module Controllers
    module Users
      class Create
        include Api::Action

        params do
          required(:user).schema do
            required(:email).filled(:str?, format?: /@/)
            required(:github_token).filled(:str?)
            required(:passphrase).filled(:str?)
          end
        end

        def call(params)
          repository = UserRepository.new
          repository.create_master_user(params[:user])
          self.body = { user: repository.master_user.serialize }
        end
      end
    end
  end
end
