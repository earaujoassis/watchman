# frozen_string_literal: true

module Helpers
  module Fixtures
    def fixture_generate_action
      repository = UserRepository.new
      user = fixture_generate_github_user
      credential = repository.add_credential(user)
      application = repository.add_application(user, {
        full_name: "testing/application",
        description: "testing application",
        managed_realm: "none",
        managed_projects: "none"
      })
      params = {
        type: "git_ops_updater",
        description: "testing context action",
        payload: {
          managed_realm: "none",
          managed_project: "none",
          commit_hash: "320dj3e"
        }
      }
      Backdoor::Commands::ActionCreateCommand.new(
        params: params, application: application, credential: credential
      ).perform
    end
  end
end
