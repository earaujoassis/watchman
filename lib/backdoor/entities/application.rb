# frozen_string_literal: true

class Application < Hanami::Entity
  def serialize
    {
      id: self.uuid,
      full_name: self.full_name,
      description: self.description,
      actions: self.actions&.map(&:serialize_for_web)
    }
  end
end
