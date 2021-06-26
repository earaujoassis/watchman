# frozen_string_literal: true

require "base64"
require "oauth2"

class Backdoor::Services::OAuth
  class Error < StandardError; end

  attr_reader :oauth_service_url
  attr_reader :callback_url

  SCOPE = "read"

  class << self
    def factory
      self.new(
        oauth_service_url: ENV["WATCHMAN_OAUTH_SERVICE_URL"],
        client_key: ENV["WATCHMAN_OAUTH_CLIENT_KEY"],
        client_secret: ENV["WATCHMAN_OAUTH_CLIENT_SECRET"],
        callback_url: ENV["WATCHMAN_OAUTH_CALLBACK_URL"]
      )
    end
  end

  def initialize(oauth_service_url:, client_key:, client_secret:, callback_url:)
    @oauth_service_url = oauth_service_url
    @client_key = client_key
    @client_secret = client_secret
    @callback_url = callback_url
    @client = OAuth2::Client.new(client_key, client_secret, site: oauth_service_url, scope: SCOPE)
    @token = nil
  end

  def authorize_url
    @client.auth_code.authorize_url(redirect_uri: callback_url, scope: SCOPE)
  end

  def retrieve_token(code:)
    @token ||= begin
      @client.auth_code.get_token(
        code,
        redirect_uri: callback_url,
        headers: { "Authorization" => "Basic #{client_authorization_token}" }
      )
    rescue StandardError => e
      raise Error, "something unexpected happened while connecting to the OAuth2 provider: #{e.message}"
    end
  end

  def retrieve_user_data
    raise Error, "token is not available" if @token.nil?

    begin
      response = @token.post("/api/users/introspect", body: { user_id: @token.params["user_id"] })
      JSON.parse(response.body, symbolize_names: true)
    rescue StandardError => e
      raise Error, "something unexpected happened while connecting to the OAuth2 provider: #{e.message}"
    end
  end

  private

  def client_authorization_token
    Base64.strict_encode64("#{@client_key}:#{@client_secret}").strip
  end
end
