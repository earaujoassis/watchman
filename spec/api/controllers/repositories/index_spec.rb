# frozen_string_literal: true

RSpec.describe Api::Controllers::Repositories::Index, type: :action do
  let(:github_response) { github_repositories_response }

  before(:each) do
    clear_repositories
  end

  it "should return Bad Request when missing any required param" do
    perform_request
    expect(status_code).to eq 400
  end

  it "should return Not Found when there's no user for given :id" do
    perform_request_with_params({ id: "inexistent" })
    expect(status_code).to eq 404
    expect(body).to eq({ error: "user not found" })
  end

  it "should return Service Unavailable when encryption key version has changed" do
    user = fixture_generate_github_user
    original_version = ENV["WATCHMAN_SECRET_KEY_VERSION"]
    ENV["WATCHMAN_SECRET_KEY_VERSION"] = "tKcheA1MsfyIweBZ"
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 503
    expect(body).to eq({ error: "version mismatch; cannot decrypt" })
    ENV["WATCHMAN_SECRET_KEY_VERSION"] = original_version
  end

  it "should return user's repositories for given :id" do
    stub_request(:get, "https://api.github.com/user/repos?per_page=5&sort=asc&type=all")
      .with(
        headers: {
          "Accept" => "application/vnd.github.v3+json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Authorization" => "token testing_github_token",
          "Content-Type" => "application/json"
        })
      .to_return(status: 200, body: github_response, headers: { "Content-Type" => "application/json" })
    user = fixture_generate_github_user
    perform_request_with_params({ id: user.uuid })
    expect(status_code).to eq 200
    expect(body[:user]).to have_key(:repositories)
  end
end
