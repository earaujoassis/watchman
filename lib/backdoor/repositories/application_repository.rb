class ApplicationRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :server
    has_many :actions
  end

  def find(uuid)
    applications.where(uuid: uuid).first
  end

  # FIXME belongs_to associations are not properly working
  def find_with_user(uuid)
    aggregate(:user)
      .where(uuid: uuid)
      .map_to(Application)
      .one
  end

  # FIXME belongs_to associations are not properly working
  def find_with_server(uuid)
    aggregate(:server)
      .where(uuid: uuid)
      .map_to(Application)
      .one
  end

  def find_with_actions(uuid)
    aggregate(:actions)
      .where(uuid: uuid)
      .order { created_at.desc }
      .map_to(Application)
      .one
  end

  def from_user_with_actions(user)
    aggregate(:actions)
      .where(user_id: user.id)
      .order { created_at.desc }
      .map_to(Application)
      .to_a
  end

  def child_action(application_id, action_id)
    actions
      .join(applications)
      .where(applications__uuid: application_id)
      .where(actions__uuid: action_id)
      .map_to(Action)
      .one
  end

  def pending_actions_for_server(server)
    server_id = server.id
    actions
      .join(applications)
      .where(current_status: Action::CREATED)
      .where(server_id: server_id)
      .map_to(Action)
      .to_a
  end
end
