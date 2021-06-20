# frozen_string_literal: true

require "bcrypt"

class User < Hanami::Entity
  include BCrypt

  MASTER = "master"

  def passphrase_match?(passphrase)
    Password.new(self.passphrase) == passphrase
  end

  def serialize
    {
      id: self.uuid,
      email: self.email
    }
  end
end
