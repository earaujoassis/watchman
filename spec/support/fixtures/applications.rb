# frozen_string_literal: true

module Helpers
  module Fixtures
    def fixture_generate_application(user: nil)
      repository = UserRepository.new
      user = fixture_generate_user if user.nil?
      repository.add_application(user, {
        full_name: "testing/application",
        description: "testing application",
        managed_realm: "none",
        managed_projects: "none"
      })
    end
  end
end
