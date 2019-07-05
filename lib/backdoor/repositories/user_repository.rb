require "securerandom"

class UserRepository < Hanami::Repository
  associations do
    has_many :applications
  end

  def master_user
    users.where(category: User::MASTER).first
  end

  def create_master_user(data)
    self.create(data.clone.merge({ category: User::MASTER }))
  end

  def find(uuid)
    users.where(uuid: uuid).first
  end

  def update_user(uuid, data)
    user = self.find(uuid)
    self.update(user.id, data)
  end

  def generate_credentials(uuid)
    user = self.find(uuid)
    data = {
      client_key: SecureRandom.hex(User::CLIENT_KEY_LENGTH),
      client_secret: SecureRandom.hex(User::CLIENT_SECRET_LENGTH)
    }
    self.update(user.id, data)
  end

  def authentic_client?(client_key, client_secret)
    user = users.where(client_key: client_key).first
    return false if user.nil?
    return user.client_secret == client_secret
  end

  def find_with_applications(uuid)
    aggregate(:applications).where(uuid: uuid).as(User).one
  end

  def add_project(user, data)
    assoc(:applications, user).add(data)
  end
end
