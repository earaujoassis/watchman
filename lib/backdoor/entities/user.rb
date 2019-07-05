class User < Hanami::Entity
  MASTER = "master"
  CLIENT_KEY_LENGTH = 16
  CLIENT_SECRET_LENGTH = 32

  def serialize
    {
      id: self.uuid,
      email: self.email,
      github_token: self.github_token
    }
  end
end
