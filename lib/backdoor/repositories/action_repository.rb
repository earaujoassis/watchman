# frozen_string_literal: true

class ActionRepository < Hanami::Repository
  associations do
    belongs_to :application
    belongs_to :credential
  end

  def find(uuid)
    actions.where(uuid: uuid).first
  end

  def find!(uuid)
    action = actions.where(uuid: uuid).first
    raise Backdoor::Errors::UndefinedEntity if action.nil?
    action
  end

  def all_pending
    actions.where(current_status: Action::CREATED).to_a
  end

  def executor_update(action, data)
    self.update(action.id, data)
  end

  def agent_update(action, data)
    data[:report] = Sequel.blob(data[:report][:tempfile].read)
    self.update(action.id, data)
  end
end
