# frozen_string_literal: true

require_relative "../../middleware/executor_context"

module Api
  module Controllers
    module Executors
      class ActionsShow
        include Api::Action
        include Api::ExecutorContext

        def call(params)
          repository = ActionRepository.new
          self.body = { action: repository.find!(params[:id]).serialize }.to_json
        rescue Backdoor::Errors::UndefinedEntity
          halt 404, { error: "unknown action" }.to_json
        end
      end
    end
  end
end
