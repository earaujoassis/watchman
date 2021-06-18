# frozen_string_literal: true

require "json"

module Executor
  module HttpHelpers
    def parse(request)
      JSON.parse(request.body, symbolize_names: true)
    end
  end
end
