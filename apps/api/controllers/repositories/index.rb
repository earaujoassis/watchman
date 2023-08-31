# frozen_string_literal: true

module Api::Controllers::Repositories
  class Index
    include Api::Action
    include Api::UserAuthentication

    params do
      required(:id).filled(:str?)
    end

    def call(params)
      repository = UserRepository.new
      user = repository.find!(params[:id])
      github_service = Backdoor::Services::GitHub.new(user.github_token!)
      self.body = { user: { repositories: github_service.repos.map(&:to_hash) } }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    rescue Backdoor::Services::GitHub::Error => e
      halt 500, { error: e.to_s }
    rescue Backdoor::Services::Security::Error => e
      halt 503, { error: e.to_s }
    end
  end
end
