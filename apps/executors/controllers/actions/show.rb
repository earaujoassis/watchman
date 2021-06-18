# frozen_string_literal: true

module Executors
  module Controllers
    module Actions
      class Show
        include Executors::Action

        def call(params)
          repository = ActionRepository.new
          self.body = { action: repository.find!(params[:id]).serialize }
        rescue Backdoor::Errors::UndefinedEntity
          halt 404, { error: "unknown action" }
        end
      end
    end
  end
end
