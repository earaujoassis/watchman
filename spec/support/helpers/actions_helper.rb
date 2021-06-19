# frozen_string_literal: true

module Helpers
  module Actions
    def perform_request_with_params(params)
      action = action || described_class.new
      @response = action.call(params)
      @status_code, @headers, @body = @response
    end

    def perform_request
      perform_request_with_params(Hash.new)
    end

    def status_code
      @status_code
    end

    def headers
      @headers
    end

    def body
      @body || nil
    end

    def json_body
      JSON.generate(@body)
    end
  end
end
