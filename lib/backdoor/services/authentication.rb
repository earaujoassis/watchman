# frozen_string_literal: true

require "base64"

class Backdoor::Services::Authentication
  def initialize(env)
    @env = env
  end

  def authorization_bearer
    encoded_text = @env["HTTP_AUTHORIZATION"].sub("Bearer ", "")
    Base64.decode64(encoded_text).split(":", 2)
  end

  def authentic_client?
    return true unless ENV["WATCHMAN_DISABLE_AUTHENTICATION"].nil?

    begin
      client_key, client_secret = authorization_bearer
      credential_repository = CredentialRepository.new
      credential_repository.authentic_client?(client_key, client_secret)
    rescue StandardError, PG::Error
      return false
    end
  end

  def retrieve_credential!
    client_key, client_secret = authorization_bearer
    credential_repository = CredentialRepository.new
    credential_repository.retrieve_credential!(client_key, client_secret)
  rescue StandardError
    raise Backdoor::Errors::UndefinedEntity
  end
end
