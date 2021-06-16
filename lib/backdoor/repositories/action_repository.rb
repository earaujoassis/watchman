# frozen_string_literal: true

class ActionRepository < Hanami::Repository
  associations do
    belongs_to :application
    belongs_to :credential
  end

  def find(uuid)
    actions.where(uuid: uuid).first
  end

  def executor_update(action, data)
    data[:report] = Sequel.blob(data[:report][:tempfile].read)
    self.update(action.id, data)
  end
end
