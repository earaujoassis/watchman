class ServerRepository < Hanami::Repository
  def find(hostname)
    servers.where(hostname: hostname).first
  end

  def update_server(hostname, data)
    server = self.find(hostname)
    self.update(server.id, data)
  end
end