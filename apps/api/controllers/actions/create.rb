# frozen_string_literal: true

require_relative "../authentication"

module Api
  module Controllers
    module Actions
      class Create
        include Api::Action
        include Api::Authentication

        params do
          required(:action).schema do
            required(:type).filled(:str?)
            optional(:description).filled(:str?)
            required(:payload).schema do
              required(:managed_realm).filled(:str?)
              required(:managed_project).filled(:str?)
            end
          end
        end

        def call(params)
          begin
            credential = Backdoor::Services::Authentication.new(request.env).retrieve_credential!
            application = ApplicationRepository.new.find!(params[:id])
          rescue Backdoor::Errors::UndefinedEntity
            halt 404, { error: "unknown application" }.to_json
          end

          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          begin
            command = Backdoor::Commands::ActionCreateCommand.new(
              params: params[:action], application: application, credential: credential
            ).perform
          rescue Backdoor::Errors::ActionError => e
            halt 404, { error: e.message }.to_json
          end

          self.body = ""
          self.status = 201
        end
      end
    end
  end
end
