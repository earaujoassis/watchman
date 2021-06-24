# frozen_string_literal: true

RSpec.describe Executors::Controllers::Users::Index, type: :action do
  let(:github_response) { github_user_response }

  before(:each) do
    clear_repositories
  end

  it "should return nil when no user is available" do
    perform_request
    expect(status_code).to eq 200
    expect(body).to eq({ user: nil })
  end

  it "should return Service Unavailable when encryption key version has changed" do
    user = fixture_generate_github_user
    original_version = ENV["SECRET_KEY_VERSION"]
    ENV["SECRET_KEY_VERSION"] = "tKcheA1MsfyIweBZ"
    perform_request
    expect(status_code).to eq 503
    expect(body).to eq({ error: "version mismatch; cannot decrypt" })
    ENV["SECRET_KEY_VERSION"] = original_version
  end

  it "should return the user if it already exists" do
    stub_request(:get, "https://api.github.com/user")
      .with(
        headers: {
          "Accept" => "application/vnd.github.v3+json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Authorization" => "token testing_github_token",
          "Content-Type" => "application/json"
        })
      .to_return(status: 200, body: github_response, headers: { "Content-Type" => "application/json" })
    fixture_generate_github_user
    perform_request
    expect(status_code).to eq 200
    expect(body[:user][:name]).to eq "monalisa octocat"
    expect(body[:user][:email]).to eq "octocat@github.com"
    expect(body[:user][:token]).to eq "testing_github_token"
  end
end
