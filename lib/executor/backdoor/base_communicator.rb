# frozen_string_literal: true

require "rest-client"

module Executor
  class BaseBackdoor
    def initialize(base_url:)
      @base_url = base_url
    end

    def headers
      {
        "Accept": "application/json",
        "Content-type": "application/json"
      }
    end

    def actions
      url = @base_url + "/api/executors/actions"
      RestClient::Resource.new(url, { headers: headers })
    end
  end
end
