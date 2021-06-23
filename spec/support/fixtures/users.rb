# frozen_string_literal: true

module Helpers
  module Fixtures
    def fixture_generate_user
      repository = UserRepository.new
      UserRepository.new.create_master_user({
        email: "john.doe@example.com",
        passphrase: "testing_passphrase",
        github_token: "testing_github_token"
      })
    end

    def fixture_generate_github_user
      repository = UserRepository.new
      UserRepository.new.create_master_user({
        email: "octocat@github.com",
        passphrase: "octocat_testing_passphrase",
        github_token: "testing_github_token"
      })
    end
  end
end
