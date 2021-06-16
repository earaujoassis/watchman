# frozen_string_literal: true

module Api
  module Controllers
    module Servers
      class Index
        include Api::Action

        def call(params)
          repository = ServerRepository.new
          servers = repository.all_serialized
          self.body = { servers: servers }.to_json
        end
      end
    end
  end
end
