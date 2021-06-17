# frozen_string_literal: true

# require_relative "../../backdoor/entities/action"

require_relative "../helpers/http_helpers"

module Executor
  module Users
    class << self
      include HttpHelpers

      def users
        @users ||=
          BaseBackdoor.new(base_url: ENV["WATCHMAN_URL"] || "http://localhost:3000").users
      end

      def user
        parse(users.get)
      rescue Errno::ECONNREFUSED
        raise HttpError, "connection refused"
      rescue RestClient::InternalServerError
        raise HttpError, "server error"
      end
    end
  end
end
