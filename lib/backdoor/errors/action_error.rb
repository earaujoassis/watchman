# frozen_string_literal: true

require_relative "./base"

class Backdoor::Errors::ActionError < Backdoor::Error
  attr_reader :errors

  def initialize(msg, errors = Hash.new)
    super(msg)
    @errors = errors
  end
end
