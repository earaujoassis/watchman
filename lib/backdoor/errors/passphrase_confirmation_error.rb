# frozen_string_literal: true

class Backdoor::Errors::PassphraseConfirmationError < Backdoor::Error
  def initialize(msg = "wrong passphrase")
    super
  end
end
