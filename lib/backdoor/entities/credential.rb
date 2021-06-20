# frozen_string_literal: true

require "bcrypt"

class Credential < Hanami::Entity
  CLIENT_KEY_LENGTH = 16
  CLIENT_SECRET_LENGTH = 32

  include BCrypt

  def client_secret_match?(client_secret)
    Password.new(self.client_secret) == client_secret
  end

  def serialize
    {
      id: self.uuid,
      client_key: self.client_key,
      description: self.description,
      is_active: self.is_active
    }
  end
end
