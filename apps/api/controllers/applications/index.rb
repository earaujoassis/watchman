# frozen_string_literal: true

module Api::Controllers::Applications
  class Index
    include Api::Action
    include Api::UserAuthentication

    params do
      required(:id).filled(:str?)
    end

    def call(params)
      repository = UserRepository.new
      user = repository.find!(params[:id])
      applications = ApplicationRepository.new.from_user_with_actions(user)
      self.body = { user: { applications: applications.map(&:serialize) } }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    end
  end
end
