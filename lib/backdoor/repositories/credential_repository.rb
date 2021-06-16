# frozen_string_literal: true

class CredentialRepository < Hanami::Repository
  associations do
    belongs_to :user
    has_many :actions
  end

  def find(uuid)
    credentials.where(uuid: uuid).first
  end

  def inactivate(user, credential)
    credential = credentials
      .join(users)
      .where(users__uuid: user.uuid)
      .where(credentials__uuid: credential.uuid)
      .map_to(Credential)
      .one
    self.update(credential.id, {is_active: false})
  end

  def authentic_client?(client_key, client_secret)
    credential = credentials
      .where(client_key: client_key)
      .where(client_secret: client_secret)
      .where(is_active: true)
      .first
    return false if credential.nil?
    true
  end

  def retrieve_credential!(client_key, client_secret)
    credential = credentials
      .where(client_key: client_key)
      .where(client_secret: client_secret)
      .where(is_active: true)
      .first
    raise Backdoor::Errors::UndefinedEntity if credential.nil?
    credential
  end

  # FIXME belongs_to associations are not properly working
  def find_with_user(uuid)
    aggregate(:user).where(uuid: uuid).map_to(Credential).one
  end
end
