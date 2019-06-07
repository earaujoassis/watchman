class UserRepository < Hanami::Repository
  associations do
    has_many :applications
  end

  def master_user
    users.where(category: User::MASTER).first
  end

  def create_master_user(data)
    self.create(data.clone.merge({ category: User::MASTER }))
  end

  def update_master_user(uuid, data)
    user = self.find(uuid)
    self.update(user.id, data)
  end

  def find(uuid)
    users.where(uuid: uuid).first
  end

  def find_with_applications(uuid)
    aggregate(:applications).where(uuid: uuid).as(User).one
  end

  def add_project(user, data)
    assoc(:applications, user).add(data)
  end
end
