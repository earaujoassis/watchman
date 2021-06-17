# frozen_string_literal: true

require_relative "../../middleware/authentication"

module Api
  module Controllers
    module Applications
      class Show
        include Api::Action
        include Api::Authentication

        def call(params)
          repository = ApplicationRepository.new
          application = repository.find(params[:id])
          halt 404, { error: "unknown application" }.to_json if application.nil?
          self.body = application.configuration_file
        end
      end
    end
  end
end
