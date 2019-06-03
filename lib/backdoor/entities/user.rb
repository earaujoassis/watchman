class User < Hanami::Entity
  MASTER = 'master'

  def serialize
    {
      id: self.id,
      email: self.email,
      github_token: self.github_token
    }
  end
end
