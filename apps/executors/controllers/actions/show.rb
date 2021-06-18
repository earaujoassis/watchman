# frozen_string_literal: true

module Executors
  module Controllers
    module Actions
      class Show
        include Executors::Action
        include Executors::SidecarContext

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
