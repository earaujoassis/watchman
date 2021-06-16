# frozen_string_literal: true

require_relative "../authentication"

module Api
  module Controllers
    module Actions
      class Update
        include Api::Action
        include Api::Authentication
        MEGABYTE = 1024 ** 2

        params do
          required(:action).schema do
            required(:current_status).filled(:str?)
            optional(:status_reason).filled(:str?)
            optional(:report).filled(size?: 1..(2 * MEGABYTE))
          end
        end

        def call(params)
          repository = ApplicationRepository.new
          action = repository.child_action(params[:application_id], params[:action_id])
          halt 404, { error: "unknown action" }.to_json if action.nil?

          action_repository = ActionRepository.new
          action_repository.executor_update(action, params[:action])

          action = repository.child_action(params[:application_id], params[:action_id])
          status 201, { action: action.serialize }.to_json
        end
      end
    end
  end
end
