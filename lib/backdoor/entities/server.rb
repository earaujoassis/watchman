class Server < Hanami::Entity
  def serialize
    {
      hostname: self.hostname,
      ip: self.ip,
      updated_at: self.updated_at
    }
  end
end
