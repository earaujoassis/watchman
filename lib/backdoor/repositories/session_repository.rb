# frozen_string_literal: true

class SessionRepository < Hanami::Repository
  associations do
    belongs_to :user
  end

  def find(uuid)
    sessions.where(uuid: uuid).first
  end

  def inactivate(user, session)
    session = sessions
      .join(users)
      .where(users__uuid: user.uuid)
      .where(sessions__uuid: sessions.uuid)
      .map_to(Session)
      .one
    self.update(sessions.id, { is_active: false })
  end

  def retrieve_session!(uuid)
    session = sessions
      .where(uuid: uuid)
      .where(is_active: true)
      .first
    raise Backdoor::Errors::UndefinedEntity, "session not found" if session.nil?
    session
  end

  # FIXME belongs_to associations are not properly working
  def find_with_user(uuid)
    aggregate(:user).where(uuid: uuid).map_to(Session).one
  end
end
