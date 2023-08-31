# frozen_string_literal: true

module Api::Controllers::HealthCheck
  class Index
    include Api::Action

    def call(params)
      UserRepository.new.master_user # simply check DB connection
      self.body = { message: "healthy" }
    end
  end
end
