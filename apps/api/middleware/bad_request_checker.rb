# frozen_string_literal: true

module Api
  module BadRequestChecker
    def self.included(action)
      action.class_eval do
        before :check_params!
      end
    end

    private

    def check_params!
      if params.respond_to?(:errors) && !params.errors.empty?
        halt 400, { error: params.errors }
      end
    end
  end
end
