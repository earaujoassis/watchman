# frozen_string_literal: true

class Action < Hanami::Entity
  ACTION_TYPES = [
    DEPLOY = :A001
  ].freeze
  ACTION_REASON = {
    A001: "Deploy",
  }.freeze
  STATUS_TYPES = [
    CREATED = "created",
    RUNNING = "running",
    FINISHED = "finished",
    FAILED = "failed"
  ].freeze

  class << self
    def valid_status?(status)
      STATUS_TYPES.include?(status)
    end
  end

  def serialize
    data = JSON.parse(self.payload)
    data.merge({
      action_id: self.uuid,
      current_status: self.current_status
    })
  end

  def serialize_for_web
    {
      id: self.uuid,
      description: self.description,
      current_status: self.current_status,
      status_reason: self.status_reason
    }
  end
end
