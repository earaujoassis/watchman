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

  it "should the user if it already exists" do
    stub_request(:get, "https://api.github.com/user")
      .with(
        headers: {
          "Accept" => "application/vnd.github.v3+json",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Authorization" => "token github_token",
          "Content-Type" => "application/json"
        })
      .to_return(status: 200, body: github_response, headers: { "Content-Type" => "application/json" })
    UserRepository.new.create_master_user({
      email: "octocat@github.com",
      passphrase: "octocat_testing_password",
      github_token: "github_token"
    })
    perform_request
    expect(status_code).to eq 200
    expect(body[:user][:name]).to eq "monalisa octocat"
    expect(body[:user][:email]).to eq "octocat@github.com"
    expect(body[:user][:token]).to eq "github_token"
  end
end
