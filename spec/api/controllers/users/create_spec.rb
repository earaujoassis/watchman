# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Create, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when there's any missing attribute" do
    perform_request
    expect(status_code).to eq 400
    expect(body).to eq({ error: { user: ["is missing"] } })
  end

  it "should create a new master user" do
    perform_request_with_params({
      user: {
        email: "john.doe@example.com",
        passphrase: "testingpassword",
        github_token: "testingtoken"
      }
    })
    expect(status_code).to eq 200
    expect(body[:user][:email]).to eq "john.doe@example.com"
    expect(body[:user][:github_token]).to eq "******gtoken"
  end
end
