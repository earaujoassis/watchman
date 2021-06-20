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
    check_existence!(find(uuid))
  end

  def all_pending
    actions.where(current_status: Action::CREATED).to_a
  end

  def all_pending_with_application
    aggregate(:application)
      .where(current_status: Action::CREATED)
      .map_to(Action)
      .to_a
  end

  def executor_update(action, data)
    self.update(action.id, data)
  end

  def agent_update(action, data)
    data[:report] = Sequel.blob(data[:report][:tempfile].read)
    self.update(action.id, data)
  end

  private

  def check_existence!(entity, message = "action not found")
    raise Backdoor::Errors::UndefinedEntity, message if entity.nil?
    entity
  end
end
