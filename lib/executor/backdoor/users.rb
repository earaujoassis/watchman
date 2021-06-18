# frozen_string_literal: true

# require_relative "../../backdoor/entities/action"

require_relative "../helpers/http_helpers"

module Executor
  module Users
    class << self
      include HttpHelpers

      def users
        @users ||=
          BaseBackdoor.new.users
      end

      def user
        parse(users.get)
      rescue Errno::ECONNREFUSED
        raise HttpError, "connection refused"
      rescue RestClient::InternalServerError
        raise HttpError, "server error"
      rescue RestClient::Unauthorized
        raise HttpError, "unauthorized request"
      end
    end
  end
end
