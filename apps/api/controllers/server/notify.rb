module Api
  module Controllers
    module Server
      class Notify
        include Api::Action

        params do
          required(:server).schema do
            required(:hostname).filled(:str?)
            required(:ip).filled(:str?)
            required(:latest_version).filled(:str?)
          end
        end

        def call(params)
          self.format = :json

          authentication = Backdoor::Services::Authentication.new(request.env)
          unless authentication.authentic_client?
            status 401, { error: "Invalid client credentials" }.to_json
            return
          end

          unless params.errors.empty?
            status 400, { error: params.errors }.to_json
            return
          end

          server_repository = ServerRepository.new
          server = server_repository.find(params[:server][:hostname])
          if server.nil?
            server_repository.create(params[:server])
          else
            server_repository.update_server(params[:server][:hostname], params[:server])
          end

          Backdoor::Ws::Connection.broadcast({ servers: server_repository.all_serialized }.to_json)

          status 201, {
            version: Backdoor::VERSION,
            server: server_repository.find(params[:server][:hostname]).serialize
          }.to_json
        end
      end
    end
  end
end
