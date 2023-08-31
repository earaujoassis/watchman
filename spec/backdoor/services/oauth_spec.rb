# frozen_string_literal: true

RSpec.describe Backdoor::Services::OAuth, type: :service do
  let(:service) { described_class.factory }
  let(:retrieve_token_response) { Helpers::Fixtures.load_json(name: "oauth_retrieve_token_response") }
  let(:retrieve_user_data_response) { Helpers::Fixtures.load_json(name: "oauth_retrieve_user_data_response") }

  describe ".factory" do
    it "should create an service instance with values from ENV var" do
      service = described_class.factory
      expect(service.oauth_service_url).to eq("http://localhost:8080")
      expect(service.callback_url).to eq("http://localhost:3000/callback")
    end
  end

  describe "#authorize_url" do
    it "should generate a valid authorization url" do
      authorize_url = "http://localhost:8080/oauth/authorize?client_id=oauth_client_key&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fcallback&response_type=code&scope=read"
      expect(service.authorize_url).to eq(authorize_url)
    end
  end

  describe "#retrieve_token" do
    it "should successfully retrieve a token using the provided authorization code" do
      stub_request(:post, "http://localhost:8080/oauth/token").
        with(
          body: {
            "client_id" => "oauth_client_key",
            "client_secret" => "oauth_client_secret",
            "code" => "testing_code",
            "grant_type" => "authorization_code",
            "redirect_uri" => "http://localhost:3000/callback"
          },
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Basic b2F1dGhfY2xpZW50X2tleTpvYXV0aF9jbGllbnRfc2VjcmV0",
            "Content-Type" => "application/x-www-form-urlencoded"
        })
        .to_return(status: 200, body: retrieve_token_response, headers: { "Content-Type" => "application/json" })
      token = service.retrieve_token(code: "testing_code")
      expect(token.params).to have_key("_status")
      expect(token.params["_status"]).to eq("success")
      expect(token.params["user_id"]).to eq("user_id")
    end
  end

  describe "#retrieve_user_data" do
    it "should raise an exception if the token has not been retrieved" do
      expect { service.retrieve_user_data }.to raise_error(Backdoor::Services::OAuth::Error, "token is not available")
    end

    it "should successfully retrieve user data" do
      stub_request(:post, "http://localhost:8080/oauth/token")
        .with(
          body: {
            "client_id" => "oauth_client_key",
            "client_secret" => "oauth_client_secret",
            "code" => "testing_code",
            "grant_type" => "authorization_code",
            "redirect_uri" => "http://localhost:3000/callback"
          },
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Basic b2F1dGhfY2xpZW50X2tleTpvYXV0aF9jbGllbnRfc2VjcmV0",
            "Content-Type" => "application/x-www-form-urlencoded"
        })
        .to_return(status: 200, body: retrieve_token_response, headers: { "Content-Type" => "application/json" })

      stub_request(:post, "http://localhost:8080/api/users/introspect")
        .with(
          body: {
            "user_id" => "user_id"
          },
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Authorization" => "Bearer access_token",
            "Content-Type" => "application/x-www-form-urlencoded"
          })
        .to_return(status: 200, body: retrieve_user_data_response, headers: { "Content-Type" => "application/json" })

      token = service.retrieve_token(code: "testing_code")
      expect(token.params).to have_key("_status")
      expect(token.params["_status"]).to eq("success")
      expect(token.params["user_id"]).to eq("user_id")
      user_data = service.retrieve_user_data
      expect(user_data).to have_key(:user)
      expect(user_data[:user][:first_name]).to eq("John")
      expect(user_data[:user][:last_name]).to eq("Doe")
    end
  end
end
