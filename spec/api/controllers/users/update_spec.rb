# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Update, type: :action do
  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
    expect(body).to eq({ error: { id: ["is missing"], user: ["is missing"] } })
  end

  it "should return Unauthorized when passphrase is incorrect" do
    user = fixture_generate_github_user
    perform_request_with_params({
      id: user.uuid,
      user: {
        github_token: "github_token_anew",
        passphrase_confirmation: "incorrect"
      }
    })
    expect(status_code).to eq 401
    expect(body).to eq({ error: "wrong passphrase" })
  end

  it "should return updated user" do
    user = fixture_generate_github_user
    perform_request_with_params({
      id: user.uuid,
      user: {
        github_token: "github_token_anew",
        passphrase_confirmation: "octocat_testing_passphrase"
      }
    })
    expect(status_code).to eq 200
    expect(body).to eq({
      user: {
        id: user.uuid,
        email: "octocat@github.com"
      }
    })
  end
end
