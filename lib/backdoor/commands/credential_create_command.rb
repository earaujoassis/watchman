# frozen_string_literal: true

require "bcrypt"
require "securerandom"
require_relative "./base_command"

class Backdoor::Commands::CredentialCreateCommand
  attr_reader :client_key
  attr_reader :client_secret

  def initialize(user:)
    @client_key = nil
    @client_secret = nil
    @user = user
  end

  def perform
    @client_key, @client_secret = generate_credentials
    repository = UserRepository.new
    data = {
      client_key: @client_key,
      client_secret: @client_secret
    }
    repository.add_credential(@user, data)
  end

  def generate_credentials
    [
      "W#{SecureRandom.hex(Credential::CLIENT_KEY_LENGTH)}"[0..31].upcase,
      SecureRandom.hex(Credential::CLIENT_SECRET_LENGTH)
    ]
  end
end
