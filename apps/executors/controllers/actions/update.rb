# frozen_string_literal: true

module Executors::Controllers::Actions
  class Update
    include Executors::Action

    params do
      required(:id).filled(:str?)

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
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    rescue Backdoor::Errors::CommandError => e
      halt 406, {
        error: {
          message: e.message,
          reasons: e.errors
        }
      }
    end
  end
end
