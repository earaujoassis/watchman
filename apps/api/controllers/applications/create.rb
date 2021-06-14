module Api
  module Controllers
    module Applications
      class Create
        include Api::Action
        MEGABYTE = 1024 ** 2

        params do
          required(:application).schema do
            required(:full_name).filled(:str?)
            optional(:description).filled(:str?)
            required(:managed_realm).filled(:str?)
            optional(:managed_projects).filled(:str?)
          end
        end

        def call(params)
          self.format = :json

          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: "unknown user" } if user.nil?
          begin
            application = repository.add_application(user, params[:application])
            application = ApplicationRepository.new.find(application.uuid)
          rescue Sequel::UniqueConstraintViolation
            halt 409, {
              error: {
                application: "already exists"
              }
            }.to_json
          end
          applications = ApplicationRepository.new.from_user_with_actions(user)
          status 201, { user: { apps: applications.map(&:serialize) } }.to_json
        end
      end
    end
  end
end
