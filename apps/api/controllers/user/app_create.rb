module Api
  module Controllers
    module User
      class AppCreate
        include Api::Action
        MEGABYTE = 1024 ** 2

        params do
          required(:application).schema do
            required(:full_name).filled(:str?)
            optional(:description).filled(:str?)
            required(:server_id).filled(:str?)
            required(:process_name).filled(:str?)
            optional(:configuration_file_name).filled(:str?)
            optional(:configuration_file).filled(size?: 1..(2 * MEGABYTE))
          end
        end

        def call(params)
          self.format = :json

          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: 'unknown user' } if user.nil?
          server = ServerRepository.new.find_by_id(params[:application][:server_id])
          params[:application][:server_id] = server.id
          begin
            application = repository.add_application(user, params[:application])
            application = ApplicationRepository.new.find(application.uuid)
            Backdoor::Services::ActionsFactory.create_deployment_action(application)
          rescue Sequel::UniqueConstraintViolation
            halt 409, {
              error: {
                application: 'already exists'
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
