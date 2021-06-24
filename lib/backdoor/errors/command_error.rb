# frozen_string_literal: true

class Backdoor::Errors::CommandError < Backdoor::Error
  attr_reader :errors

  def initialize(msg, errors = Hash.new)
    super(msg)
    @errors = errors
  end
end
