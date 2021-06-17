# frozen_string_literal: true

require "json"

module Executor
  module HttpHelpers
    def parse(request)
      JSON.parse(request.body)
    end
  end
end
