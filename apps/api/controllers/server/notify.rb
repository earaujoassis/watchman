require "base64"

module Api
  module Controllers
    module Server
      class Notify
        include Api::Action

        params do
          required(:server).schema do
            required(:hostname).filled(:str?)
            required(:ip).filled(:str?)
          end
        end

        def authorization_bearer
          encoded_text = request.env['HTTP_AUTHORIZATION'].sub('Bearer ', '')
          Base64.decode64(encoded_text).split(':', 2)
        end

        def call(params)
          self.format = :json

          client_key, client_secret = authorization_bearer
          user_repository = UserRepository.new
          unless user_repository.authentic_client?(client_key, client_secret)
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

          status 201, { server: server_repository.find(params[:server][:hostname]).serialize }.to_json
        end
      end
    end
  end
end
