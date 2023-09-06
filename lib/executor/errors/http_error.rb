# frozen_string_literal: true

require_relative "./base"

class Executor::HttpError < Executor::Error
  def initialize(msg)
    super
  end
end
