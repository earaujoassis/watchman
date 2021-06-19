# frozen_string_literal: true

module Api
  module Controllers
    module Servers
      class Index
        include Api::Action

        def call(params)
          repository = ServerRepository.new
          self.body = { servers: repository.all.map(&:serialize) }
        end
      end
    end
  end
end
