class UserRepository < Hanami::Repository
  def master_user
    users.where(category: User::MASTER).first
  end

  def find(uuid)
    users.where(uuid: uuid).first
  end

  def create_master_user(data)
    self.create(data.clone.merge({ category: User::MASTER }))
  end

  def update_master_user(uuid, data)
    user = self.find(uuid)
    self.update(user.id, data)
  end
end
