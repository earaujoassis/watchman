# frozen_string_literal: true

class Backdoor::Errors::UndefinedEntity < Backdoor::Error
  def initialize(msg = "entity was not found")
    super
  end
end
