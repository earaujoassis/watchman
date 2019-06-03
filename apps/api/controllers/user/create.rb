module Api
  module Controllers
    module User
      class Create
        include Api::Action

        params do
          required(:user).schema do
            required(:email).filled
            required(:github_token).filled
          end
        end

        def call(params)
          self.format = :json

          unless params.errors.empty?
            status 400, { error: params.errors }.to_json
            return
          end

          repository = UserRepository.new
          repository.create_master_user(params[:user])
          status 201, { user: repository.master_user.serialize }.to_json
        end
      end
    end
  end
end
