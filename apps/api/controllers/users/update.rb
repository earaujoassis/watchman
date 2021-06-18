# frozen_string_literal: true

module Api
  module Controllers
    module Users
      class Update
        include Api::Action

        params do
          required(:user).schema do
            required(:github_token).filled(:str?)
            required(:password_confirmation).filled(:str?)
          end
        end

        def call(params)
          halt 400, { error: params.errors } unless params.errors.empty?

          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 401, { error: "wrong password" } unless user.password == params[:user][:password_confirmation]

          repository.update_user(params[:id], params[:user].slice(:github_token))
          self.body = { user: repository.master_user.serialize }
        end
      end
    end
  end
end
