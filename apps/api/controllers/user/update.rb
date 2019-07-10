module Api
  module Controllers
    module User
      class Update
        include Api::Action

        params do
          required(:user).schema do
            required(:email).filled(:str?, format?: /@/)
            required(:github_token).filled(:str?)
          end
        end

        def call(params)
          self.format = :json

          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          repository = UserRepository.new
          repository.update_user(params[:id], params[:user])
          status 201, { user: repository.master_user.serialize }.to_json
        end
      end
    end
  end
end
