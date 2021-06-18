# frozen_string_literal: true

module Executors
  module Controllers
    module Users
      class Index
        include Executors::Action
        include Executors::SidecarContext

        def call(params)
          user = UserRepository.new.master_user
          github_service = Backdoor::Services::GitHub.new user.github_token
          github_user = github_service.user
          self.body = {
            user: {
              name: github_user[:name],
              email: user.email,
              token: user.github_token
            }
          }.to_json
        rescue Backdoor::Services::GitHub::Error => e
          halt 500, { error: e.to_s }.to_json
        end
      end
    end
  end
end
