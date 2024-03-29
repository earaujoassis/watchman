# frozen_string_literal: true

require "rest-client"

module Executor
  class BaseBackdoor
    def initialize(base_url: "http://127.0.0.1:#{ENV['WATCHMAN_SIDECAR_EXECUTOR_USE_PORT'] || 3000}")
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

    def users
      url = @base_url + "/api/executors/users"
      RestClient::Resource.new(url, { headers: headers })
    end
  end
end
