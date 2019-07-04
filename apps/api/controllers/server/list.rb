module Api
  module Controllers
    module Server
      class List
        include Api::Action

        def call(params)
          self.format = :json

          repository = ServerRepository.new
          servers = repository.all_serialized
          self.body = { servers: servers }.to_json
        end
      end
    end
  end
end
