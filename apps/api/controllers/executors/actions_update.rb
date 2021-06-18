# frozen_string_literal: true

require_relative "../../middleware/executor_context"

module Api
  module Controllers
    module Executors
      class ActionsUpdate
        include Api::Action
        include Api::ExecutorContext

        params do
          required(:action).schema do
            required(:current_status).filled(:str?)
            optional(:status_reason).filled(:str?)
          end
        end

        def call(params)
          repository = ActionRepository.new
          action = repository.find!(params[:id])

          halt 400, { error: params.errors }.to_json unless params.errors.empty?

          Backdoor::Commands::ActionUpdateCommand.new(
            params: params[:action], action: action
          ).perform

          action = repository.find(params[:id])
          self.body = { action: action.serialize }.to_json
        rescue Backdoor::Errors::UndefinedEntity
          halt 404, { error: "unknown action" }.to_json
        rescue Backdoor::Errors::ActionError => e
          halt 406, { error: e.message }.to_json
        end
      end
    end
  end
end
