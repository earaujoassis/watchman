# frozen_string_literal: true

module Executors
  module Controllers
    module Actions
      class Update
        include Executors::Action

        params do
          required(:action).schema do
            required(:current_status).filled(:str?)
            optional(:status_reason).filled(:str?)
          end
        end

        def call(params)
          repository = ActionRepository.new
          action = repository.find!(params[:id])

          halt 400, { error: params.errors } unless params.errors.empty?

          Backdoor::Commands::ActionUpdateCommand.new(
            params: params[:action], action: action
          ).perform

          action = repository.find(params[:id])
          self.body = { action: action.serialize }
        rescue Backdoor::Errors::UndefinedEntity
          halt 404, { error: "unknown action" }
        rescue Backdoor::Errors::ActionError => e
          halt 406, { error: e.message }
        end
      end
    end
  end
end
