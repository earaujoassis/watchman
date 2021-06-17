# frozen_string_literal: true

module Api
  module Controllers
    module Executors
      class ActionsIndex
        include Api::Action

        def call(params)
          repository = ActionRepository.new
          self.body = { actions: repository.all_pending.map(&:serialize) }.to_json
        end
      end
    end
  end
end
