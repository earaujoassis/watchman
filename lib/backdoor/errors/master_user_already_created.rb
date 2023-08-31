# frozen_string_literal: true

class Backdoor::Errors::MasterUserAlreadyCreated < Backdoor::Error
  def initialize(msg = "master user was already created")
    super
  end
end
