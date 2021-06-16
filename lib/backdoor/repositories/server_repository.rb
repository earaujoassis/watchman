# frozen_string_literal: true

class ServerRepository < Hanami::Repository
  associations do
    has_many :reports
  end

  def find(hostname)
    servers.where(hostname: hostname).first
  end

  def find_by_id(uuid)
    servers.where(uuid: uuid).first
  end

  def update_server(hostname, data)
    server = self.find(hostname)
    self.update(server.id, data)
  end

  def all_serialized
    self.all.map(&:serialize)
  end

  def find_with_reports(uuid)
    aggregate(:reports).where(uuid: uuid).order { created_at.desc }.map_to(Server).one
  end

  def add_report(server, data)
    assoc(:reports, server).add(data)
  end
end
