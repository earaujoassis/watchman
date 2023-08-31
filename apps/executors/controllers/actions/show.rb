# frozen_string_literal: true

module Executors::Controllers::Actions
  class Show
    include Executors::Action

    def call(params)
      repository = ActionRepository.new
      self.body = { action: repository.find!(params[:id]).serialize }
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    end
  end
end
