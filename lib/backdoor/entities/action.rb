# frozen_string_literal: true

class Action < Hanami::Entity
  STATUSES = [
    CREATED = "created",
    RUNNING = "running",
    FINISHED = "finished",
    FAILED = "failed"
  ].freeze

  TYPES = %w(git_ops_updater)

  class << self
    def valid_status?(status)
      STATUSES.include?(status)
    end

    def valid_type?(type)
      TYPES.include?(type)
    end
  end

  def valid_status?(status)
    state_machine = {
      CREATED => [RUNNING, FINISHED, FAILED],
      RUNNING => [FINISHED, FAILED],
      FINISHED => [],
      FAILED => []
    }
    state_machine[self.current_status].include?(status)
  end

  def serialize
    data = JSON.parse(self.payload, symbolize_names: true)
    data.merge({
      action_id: self.uuid,
      current_status: self.current_status,
      type: self.type
    })
  end

  def serialize_with_application
    data = JSON.parse(self.payload, symbolize_names: true)
    data.merge({
      action_id: self.uuid,
      current_status: self.current_status,
      type: self.type,
      application: self.application.full_name
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
