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
      github_token: github_token_obfuscated(length: 30)
    }
  end

  def password
    Password.new(self.passphrase)
  end

  private

  def github_token_obfuscated(length:, obfuscation_character: "*")
    obfuscation = obfuscation_character * length
    obfuscation + self.github_token[(length)..]
  end
end
