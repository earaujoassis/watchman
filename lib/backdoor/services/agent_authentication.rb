# frozen_string_literal: true

require "base64"

class Backdoor::Services::AgentAuthentication
  def initialize(env)
    @env = env
  end

  def authentic_client?
    return true unless ENV["WATCHMAN_DISABLE_AUTHENTICATION"].nil?

    begin
      client_key, client_secret = authorization_bearer
      credential = self.retrieve_credential!
      credential.client_secret_match? client_secret
    rescue StandardError, PG::Error
      return false
    end
  end

  def retrieve_credential!
    client_key, client_secret = authorization_bearer
    credential_repository = CredentialRepository.new
    credential_repository.retrieve_credential!(client_key)
  end

  private

  def authorization_bearer
    encoded_text = @env["HTTP_AUTHORIZATION"].sub("Bearer ", "")
    Base64.decode64(encoded_text).split(":", 2)
  end
end
