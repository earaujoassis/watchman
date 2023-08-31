# frozen_string_literal: true

module Api::Controllers::Servers
  class Notify
    include Api::Action
    include Api::AgentAuthentication

    params do
      required(:server).schema do
        required(:hostname).filled(:str?)
        required(:ip).filled(:str?)
        required(:latest_version).filled(:str?)
      end
    end

    def call(params)
      server_repository = ServerRepository.new
      server = server_repository.find(params[:server][:hostname])
      if server.nil?
        server_repository.create(params[:server])
      else
        server_repository.update_server(params[:server][:hostname], params[:server])
      end
      server = server_repository.find(params[:server][:hostname])
      latest_tag = Backdoor::Services::PublicGitHub.new("earaujoassis/watchman").latest_tag

      Backdoor::Sockets::Connection.broadcast({
        servers: server_repository.all.map(&:serialize)
      })

      self.body = {
        version: Backdoor::VERSION,
        available_tag: latest_tag,
        server: server.serialize
      }
    end
  end
end
