# frozen_string_literal: true

module Api::Controllers::Actions
  class Update
    include Api::Action
    include Api::Authentication
    MEGABYTE = 1024 ** 2

    params do
      required(:application_id).filled(:str?)

      required(:action_id).filled(:str?)

      required(:action).schema do
        required(:current_status).filled(:str?)
        optional(:status_reason).filled(:str?)
        optional(:report).filled(size?: 1..(2 * MEGABYTE))
      end
    end

    def call(params)
      repository = ApplicationRepository.new
      action = repository.child_action!(params[:application_id], params[:action_id])

      action_repository = ActionRepository.new
      action_repository.agent_update(action, params[:action])

      action = repository.child_action(params[:application_id], params[:action_id])
      self.body = { action: action.serialize }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    end
  end
end
