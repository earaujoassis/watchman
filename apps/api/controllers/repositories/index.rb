# frozen_string_literal: true

module Api
  module Controllers
    module Repositories
      class Index
        include Api::Action

        params do
          required(:id).filled(:str?)
        end

        def call(params)
          repository = UserRepository.new
          user = repository.find!(params[:id])
          github_service = Backdoor::Services::GitHub.new user.github_token
          self.body = { user: { repositories: github_service.repos.map(&:to_hash) } }
        rescue Backdoor::Errors::UndefinedEntity
          halt 404, { error: "unknown application" }
        rescue Backdoor::Services::GitHub::Error => e
          halt 500, { error: e.to_s }
        end
      end
    end
  end
end
