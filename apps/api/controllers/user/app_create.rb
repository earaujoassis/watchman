module Api
  module Controllers
    module User
      class AppCreate
        include Api::Action

        params do
          required(:application).schema do
            required(:full_name).filled(:str?)
            optional(:description).filled(:str?)
          end
        end

        def call(params)
          self.format = :json

          unless params.errors.empty?
            status 400, { error: params.errors }.to_json
            return
          end

          repository = UserRepository.new
          user = repository.find(params[:id])
          application = repository.add_project(user, params[:application])
          status 201, { application: application.serialize }.to_json
        end
      end
    end
  end
end
