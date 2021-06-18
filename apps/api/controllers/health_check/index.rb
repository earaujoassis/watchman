# frozen_string_literal: true

module Api
  module Controllers
    module HealthCheck
      class Index
        include Api::Action

        def call(params)
          UserRepository.new.master_user # simply check DB connection
          self.body = { message: "healthy" }.to_json
        end
      end
    end
  end
end
