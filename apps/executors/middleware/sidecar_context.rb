# frozen_string_literal: true

module Executors
  module SidecarContext
    def self.included(action)
      action.class_eval do
        before :executor_context_enforce_sidecar!
      end
    end

    private

    def executor_context_enforce_sidecar!
      sidecar = Backdoor::Services::Sidecar.new(request)
      # IMPORTANT WARNING Executor routes should be hidden behind an API Gateway
      unless sidecar.same_pod?
        halt 401, { error: "Cannot access route outside of pod" }.to_json
      end
    end
  end
end
