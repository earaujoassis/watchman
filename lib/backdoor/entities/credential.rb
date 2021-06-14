class Credential < Hanami::Entity
  def serialize
    {
      id: self.uuid,
      client_key: self.client_key,
      description: self.description
    }
  end
end
