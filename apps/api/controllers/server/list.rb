module Api
  module Controllers
    module Server
      class List
        include Api::Action

        def call(params)
          self.format = :json

          repository = ServerRepository.new
          servers = repository.all
          self.body = { servers: servers.map(&:serialize) }.to_json
        end
      end
    end
  end
end
