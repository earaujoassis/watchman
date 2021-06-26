# frozen_string_literal: true

module Api::Controllers::Credentials
  class Index
    include Api::Action

    params do
      required(:id).filled(:str?)
    end

    def call(params)
      repository = UserRepository.new
      user = repository.find_with_credentials!(params[:id])
      self.body = { user: { credentials: user.credentials.map(&:serialize) } }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    end
  end
end
