# frozen_string_literal: true

require "bcrypt"
require "securerandom"

class UserRepository < Hanami::Repository
  include BCrypt

  associations do
    has_many :applications
    has_many :credentials
  end

  def master_user
    users.where(category: User::MASTER).first
  end

  def create_master_user(data)
    data[:passphrase] = Password.create(data[:passphrase]) unless data[:passphrase].nil?
    self.create(data.clone.merge({ category: User::MASTER }))
  end

  def find(uuid)
    users.where(uuid: uuid).first
  end

  def update_user(uuid, data)
    user = self.find(uuid)
    data[:passphrase] = Password.create(data[:passphrase]) unless data[:passphrase].nil?
    self.update(user.id, data)
  end

  def find_with_applications(uuid)
    aggregate(:applications).where(uuid: uuid).map_to(User).one
  end

  def add_application(user, data)
    assoc(:applications, user).add(data)
  end

  def owned_credential(user_id, credential_id)
    credentials
      .join(users)
      .where(users__uuid: user_id)
      .where(credentials__uuid: credential_id)
      .map_to(Credential)
      .one
  end

  def find_with_credentials(uuid)
    aggregate(:credentials).where(uuid: uuid).map_to(User).one
  end

  def add_credential(user)
    data = {
      client_key: "W#{SecureRandom.hex(User::CLIENT_KEY_LENGTH)}"[0..31].upcase,
      client_secret: SecureRandom.hex(User::CLIENT_SECRET_LENGTH)
    }
    assoc(:credentials, user).add(data)
  end
end
