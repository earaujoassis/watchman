# frozen_string_literal: true

module Api::Controllers::Applications
  class Create
    include Api::Action
    include Api::UserAuthentication

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
      user = repository.find!(params[:id])
      repository.add_application(user, params[:application])
      applications = ApplicationRepository.new.from_user_with_actions(user)
      self.body = { user: { applications: applications.map(&:serialize) } }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    rescue Sequel::UniqueConstraintViolation
      halt 409, {
        error: {
          application: "already exists"
        }
      }
    end
  end
end
