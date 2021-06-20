# frozen_string_literal: true

RSpec.describe Api::Controllers::Actions::Create, type: :action do
  let(:repository) { UserRepository.new }

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
    expect(body).to eq({ error: { id: ["is missing"], action: ["is missing"] } })
  end

  it "should return Ok when all data is available and correct" do
    user = fixture_generate_user
    application = repository.add_application(user, {
      full_name: "testing/application",
      description: "testing application",
      managed_realm: "none",
      managed_projects: "none"
    })
    credential = repository.add_credential(user)
    params = {
      type: "git_ops_updater",
      # description: "testing context action", => optional
      payload: {
        managed_realm: "none",
        managed_project: "none",
        commit_hash: "320dj3e"
      }
    }
    # rubocop:disable Style/HashSyntax
    perform_request_with_params({
      "HTTP_AUTHORIZATION" => authorization_code(credential.client_key, credential.client_secret),
      id: application.uuid,
      action: params
    })
    # rubocop:enable Style/HashSyntax
    expect(status_code).to eq 201
    expect(body).to eq([""])
  end
end
