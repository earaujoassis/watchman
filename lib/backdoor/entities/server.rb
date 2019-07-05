class Server < Hanami::Entity
  def serialize
    {
      hostname: self.hostname,
      ip: self.ip,
      latest_version: self.latest_version,
      updated_at: self.updated_at
    }
  end
end
