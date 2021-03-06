# frozen_string_literal: true

class ApplicationRepository < Hanami::Repository
  associations do
    belongs_to :user
    has_many :actions
  end

  def find(uuid)
    applications.where(uuid: uuid).first
  end

  def find!(uuid)
    check_existence!(find(uuid))
  end

  # FIXME belongs_to associations are not properly working
  def find_with_user(uuid)
    aggregate(:user)
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

  def child_action!(application_id, action_id)
    check_existence!(child_action(application_id, action_id))
  end

  def pending_actions
    actions
      .join(applications)
      .where(current_status: Action::CREATED)
      .map_to(Action)
      .to_a
  end

  private

  def check_existence!(entity, message = "application not found")
    raise Backdoor::Errors::UndefinedEntity, message if entity.nil?
    entity
  end
end
