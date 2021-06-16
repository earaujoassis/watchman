# frozen_string_literal: true

module Api
  module Controllers
    module Repositories
      class Index
        include Api::Action

        def call(params)
          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: "unknown user" }.to_json if user.nil?
          github_service = Backdoor::Services::GitHub.new user.github_token
          begin
            repos = github_service.repos
            self.body = { user: { repositories: repos.map(&:to_hash) } }.to_json
          rescue Backdoor::Services::GitHub::Error => e
            halt 500, { error: e.to_s }.to_json
          end
        end
      end
    end
  end
end
