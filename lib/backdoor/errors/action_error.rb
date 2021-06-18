# frozen_string_literal: true

require_relative "./base"

class Backdoor::Errors::ActionError < Backdoor::Error
  def initialize(msg)
    super
  end
end
