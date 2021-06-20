# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Create, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
    expect(body).to eq({ error: { id: ["is missing"], application: ["is missing"] } })
  end

  it "should return Not Found for inexistent user" do
    perform_request_with_params({
      id: "inexistent",
      application: {
        full_name: "testing/project",
        managed_realm: "none",
        managed_projects: "none"
      }
    })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "user not found" })
  end

  it "should return Ok when application is created" do
    user = fixture_generate_user
    perform_request_with_params({
      id: user.uuid,
      application: {
        full_name: "testing/project",
        managed_realm: "none",
        managed_projects: "none"
      }
    })
    applications = ApplicationRepository.new.from_user_with_actions(user)
    expect(status_code).to eq 200
    expect(body).to eq({ user: { applications: applications.map(&:serialize) } })
  end
end
