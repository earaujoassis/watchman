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
          self.format = :json

          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 401, { error: "wrong password" }.to_json unless user.password == params[:user][:password_confirmation]

          repository.update_user(params[:id], params[:user].slice(:github_token))
          status 201, { user: repository.master_user.serialize }.to_json
        end
      end
    end
  end
end
