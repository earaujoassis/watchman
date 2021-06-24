# frozen_string_literal: true

require "tmpdir"

module Executor
  module Core
    class << self
      def perform(commands)
        user = Executor::Users.user[:user]
        actions = Executor::Actions.all_pending[:actions]
        Executor.logger.warn("No actions to process") if actions.empty?
        actions.each do |action|
          Dir.mktmpdir do |workdir|
            action_type = action[:type].to_sym
            command = commands[action_type]
            if command.nil?
              unsupported_type(action: action)
            else
              begin
                command.perform!(user: user, action: action, workdir: workdir)
                success(action: action)
              rescue Executor::Error => e
                failure(action: action, error: e.to_s)
              end
            end
          end
        end
      rescue Executor::Error => e
        Executor.logger.error("Failed to process actions: #{e}")
      end

      def success(action:)
        Executor::Actions.update(
          uuid: action[:action_id], current_status: "finished", status_reason: "successfully completed"
        )
      end

      def failure(action:, error: error_message)
        Executor::Actions.update(
          uuid: action[:action_id], current_status: "failed", status_reason: error_message
        )
      end

      def unsupported_type(action:)
        Executor::Actions.update(
          uuid: action[:action_id], current_status: "failed", status_reason: "unsupported type"
        )
      end
    end
  end
end
