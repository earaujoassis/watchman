module Api
  module Controllers
    module Server
      class Notify
        include Api::Action
        include Api::Authentication

        params do
          required(:server).schema do
            required(:hostname).filled(:str?)
            required(:ip).filled(:str?)
            required(:latest_version).filled(:str?)
          end
        end

        def call(params)
          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          server_repository = ServerRepository.new
          server = server_repository.find(params[:server][:hostname])
          if server.nil?
            server_repository.create(params[:server])
          else
            server_repository.update_server(params[:server][:hostname], params[:server])
          end

          Backdoor::Ws::Connection.broadcast({
            servers: server_repository.all_serialized
          }.to_json)

          status 201, {
            version: Backdoor::VERSION,
            available_tag: Backdoor::Services::PublicGitHub.new("earaujoassis/watchman").latest_tag,
            server: server_repository.find(params[:server][:hostname]).serialize
          }.to_json
        end
      end
    end
  end
end
