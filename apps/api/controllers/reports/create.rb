# frozen_string_literal: true

module Api::Controllers::Reports
  class Create
    include Api::Action
    include Api::AgentAuthentication

    params do
      required(:server).schema do
        required(:hostname).filled(:str?)
        required(:ip).filled(:str?)
        required(:latest_version).filled(:str?)
      end

      required(:report).schema do
        required(:subject).filled(:str?)
      end
    end

    def call(params)
      server_repository = ServerRepository.new
      server = server_repository.find(params[:server][:hostname])
      if server.nil?
        server = server_repository.create(params[:server])
      else
        server_repository.update_server(params[:server][:hostname], params[:server])
      end

      Backdoor::Sockets::Connection.broadcast({ servers: server_repository.all.map(&:serialize) })

      report = server_repository.add_report(server, params[:report])

      self.body = { report: { id: report.uuid } }
    end
  end
end
