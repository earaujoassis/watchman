# frozen_string_literal: true

RSpec.describe "Requests: /api/executors/users", type: :requests do
  let(:app) { Hanami.app }
  let(:github_response) { github_user_response }

  before(:each) do
    clear_repositories
  end

  it "GET /api/executors/users => Ok: { user: nil }" do
    get "/api/executors/users"

    expect(last_response.status).to be(200)
    expect(last_response.body).to eq(JSON.generate({ user: nil }))
  end

  it "GET /api/executors/users => Ok: { user: <entity> }" do
    stub_request(:get, "https://api.github.com/user")
      .with(
        headers: {
          "Accept" => "application/vnd.github.v3+json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Authorization" => "token github_token",
          "Content-Type" => "application/json"
        })
      .to_return(status: 200, body: github_response, headers: { "Content-Type" => "application/json" })
    fixture_generate_github_user

    get "/api/executors/users"

    expect(last_response.status).to be(200)
    expect(last_response.body).to eq(JSON.generate({
      user: {
        name: "monalisa octocat",
        email: "octocat@github.com",
        token: "github_token"
      }
    }))
  end
end
