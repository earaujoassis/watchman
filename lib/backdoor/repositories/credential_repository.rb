class CredentialRepository < Hanami::Repository
  associations do
    belongs_to :user
  end

  def find(uuid)
    credentials.where(uuid: uuid).first
  end

  # FIXME belongs_to associations are not properly working
  def find_with_user(uuid)
    aggregate(:user).where(uuid: uuid).map_to(Credential).one
  end
end
