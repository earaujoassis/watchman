# frozen_string_literal: true

require "bcrypt"

class User < Hanami::Entity
  include BCrypt

  MASTER = "master"
  CLIENT_KEY_LENGTH = 16
  CLIENT_SECRET_LENGTH = 32

  def serialize
    {
      id: self.uuid,
      email: self.email,
      github_token: github_token_obfuscated(length: self.github_token.length * 0.5)
    }
  end

  def passphrase_match?(passphrase)
    Password.new(self.passphrase) == passphrase
  end

  private

  def github_token_obfuscated(length:, obfuscation_character: "*")
    obfuscation = obfuscation_character * length
    obfuscation + self.github_token[(length)..]
  end
end
