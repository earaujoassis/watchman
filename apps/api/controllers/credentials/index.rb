# frozen_string_literal: true

module Api
  module Controllers
    module Credentials
      class Index
        include Api::Action

        params do
          required(:id).filled(:str?)
        end

        def call(params)
          repository = UserRepository.new
          user = repository.find_with_credentials(params[:id])
          halt 404, { error: "unknown user" } if user.nil?

          self.body = { user: { credentials: user.credentials.map(&:serialize) } }
        end
      end
    end
  end
end
