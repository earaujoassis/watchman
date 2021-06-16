# frozen_string_literal: true

class Credential < Hanami::Entity
  def serialize
    {
      id: self.uuid,
      client_key: self.client_key,
      description: self.description,
      is_active: self.is_active
    }
  end
end
