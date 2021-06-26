# frozen_string_literal: true

module Executors::Controllers::Actions
  class Index
    include Executors::Action

    def call(params)
      repository = ActionRepository.new
      self.body = {
        actions: repository.all_pending_with_application.map(&:serialize_with_application)
      }
    end
  end
end
