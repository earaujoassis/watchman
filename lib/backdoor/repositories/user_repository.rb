# frozen_string_literal: true

class UserRepository < Hanami::Repository
  include BCrypt

  associations do
    has_many :applications
    has_many :credentials
  end

  def master_user
    users.where(category: User::MASTER).first
  end

  def master_user!
    check_existence!(master_user)
  end

  def create_master_user(data)
    data[:passphrase] = Password.create(data[:passphrase]) unless data[:passphrase].nil?
    self.create(data.clone.merge({ category: User::MASTER }))
  end

  def find(uuid)
    users.where(uuid: uuid).first
  end

  def find!(uuid)
    check_existence!(find(uuid))
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

  def owned_credential!(user_id, credential_id)
    check_existence!(owned_credential(user_id, credential_id), "credential not found")
  end

  def find_with_credentials(uuid)
    aggregate(:credentials).where(uuid: uuid).map_to(User).one
  end

  def find_with_credentials!(uuid)
    check_existence!(find_with_credentials(uuid))
  end

  def add_credential(user, data)
    data[:client_secret] = Password.create(data[:client_secret]) unless data[:client_secret].nil?
    assoc(:credentials, user).add(data)
  end

  private

  def check_existence!(entity, message = "user not found")
    raise Backdoor::Errors::UndefinedEntity, message if entity.nil?
    entity
  end
end
