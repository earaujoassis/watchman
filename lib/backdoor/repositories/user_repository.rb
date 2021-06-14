require "securerandom"
require "bcrypt"

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

  def authentic_client?(client_key, client_secret)
    user = users.where(client_key: client_key).first
    return false if user.nil?
    return user.client_secret == client_secret
  end

  def find_with_applications(uuid)
    aggregate(:applications).where(uuid: uuid).map_to(User).one
  end

  def add_application(user, data)
    assoc(:applications, user).add(data)
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
