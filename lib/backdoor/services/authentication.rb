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
    return true unless Hanami.env?(:production)

    begin
      client_key, client_secret = authorization_bearer
    rescue StandardError
      return false
    end

    credential_repository = CredentialRepository.new
    credential_repository.authentic_client?(client_key, client_secret)
  end
end
