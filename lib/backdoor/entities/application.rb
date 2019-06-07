class Application < Hanami::Entity
  def serialize
    {
      id: self.uuid,
      full_name: self.full_name,
      description: self.description
    }
  end
end
