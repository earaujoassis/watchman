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

  it "should must complain about the passphrase size" do
    perform_request_with_params({
      user: {
        email: "john.doe@example.com",
        passphrase: "testing",
        github_token: "testing_token"
      }
    })
    expect(status_code).to eq 400
    expect(body).to eq({ error: { user: { passphrase: ["doesn't have minimum size of 16"] } } })
  end

  it "should create a new master user" do
    perform_request_with_params({
      user: {
        email: "john.doe@example.com",
        passphrase: "testing_passphrase",
        github_token: "testing_token"
      }
    })
    expect(status_code).to eq 200
    expect(body[:user][:email]).to eq "john.doe@example.com"
  end
end
