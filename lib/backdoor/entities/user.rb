class User < Hanami::Entity
  MASTER = 'master'

  def serialize
    {
      id: self.uuid,
      email: self.email,
      github_token: self.github_token
    }
  end
end
