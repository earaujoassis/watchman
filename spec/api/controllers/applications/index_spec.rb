# frozen_string_literal: true

RSpec.describe Api::Controllers::Applications::Index, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
    expect(body).to eq({ error: { id: ["is missing"] } })
  end

  it "should return an empty list when there's no application for user" do
    user = fixture_generate_user
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body).to eq({ user: { applications: [] } })
  end

  it "should return a list of applications" do
    user = fixture_generate_user
    fixture_generate_application(user: user)
    applications = ApplicationRepository.new.from_user_with_actions(user)
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body).to eq({ user: { applications: applications.map(&:serialize) } })
  end
end
