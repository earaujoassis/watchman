class ActionRepository < Hanami::Repository
  associations do
    belongs_to :application
  end

  def find(uuid)
    actions.where(uuid: uuid).first
  end

  def executor_update(action, data)
    action = self.find(action.uuid)
    data[:report] = Sequel.blob(data[:report][:tempfile].read)
    self.update(action.id, data)
  end
end
