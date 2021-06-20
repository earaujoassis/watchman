# frozen_string_literal: true

module Api
  module Controllers
    module Applications
      class Create
        include Api::Action

        params do
          required(:id).filled(:str?)

          required(:application).schema do
            required(:full_name).filled(:str?)
            optional(:description).filled(:str?)
            required(:managed_realm).filled(:str?)
            optional(:managed_projects).filled(:str?)
          end
        end

        def call(params)
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
            }
          end
          applications = ApplicationRepository.new.from_user_with_actions(user)
          self.body = { user: { applications: applications.map(&:serialize) } }
        end
      end
    end
  end
end
