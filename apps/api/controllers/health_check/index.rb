module Api
  module Controllers
    module HealthCheck
      class Index
        include Api::Action

        def call(params)
          UserRepository.new.master_user # simply check DB connection
          status 200, { message: "healthy" }.to_json
        end
      end
    end
  end
end
