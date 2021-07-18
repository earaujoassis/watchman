# frozen_string_literal: true

class Session < Hanami::Entity
  def serialize
    Hash.new
  end
end
