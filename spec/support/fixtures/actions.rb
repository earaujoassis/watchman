# frozen_string_literal: true

module Helpers
  module Fixtures
    def fixture_generate_action
      repository = UserRepository.new
      user = repository.create_master_user({
        email: "octocat@github.com",
        passphrase: "octocat_testing_password",
        github_token: "github_token"
      })
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
