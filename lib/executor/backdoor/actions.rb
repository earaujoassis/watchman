# frozen_string_literal: true

# require_relative "../../backdoor/entities/action"

require_relative "../helpers/http_helpers"

module Executor
  module Actions
    class << self
      include HttpHelpers

      def actions
        @actions ||=
          BaseBackdoor.new.actions
      end

      def all_pending
        parse(actions.get)
      rescue Errno::ECONNREFUSED
        raise HttpError, "connection refused"
      rescue RestClient::InternalServerError
        raise HttpError, "server error"
      rescue RestClient::Unauthorized
        raise HttpError, "unauthorized request"
      end

      def update(uuid:, current_status:, status_reason:)
        action = actions["/#{uuid}"]
        payload = { action: { current_status: current_status, status_reason: status_reason } }
        action.put(payload)
        parse(action.get)
      rescue Errno::ECONNREFUSED
        raise HttpError, "connection refused"
      rescue RestClient::NotFound
        raise HttpError, "unknown action"
      rescue RestClient::InternalServerError
        raise HttpError, "server error"
      rescue RestClient::NotAcceptable
        raise HttpError, "cannot update"
      rescue RestClient::Unauthorized
        raise HttpError, "unauthorized request"
      end
    end
  end
end
