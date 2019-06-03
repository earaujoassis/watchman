class UserRepository < Hanami::Repository
  def master_user
    users.where(category: User::MASTER).first
  end

  def create_master_user(data)
    self.create(data.clone.merge({ category: User::MASTER }))
  end

  def update_master_user(id, data)
    self.update(id, data)
  end
end
