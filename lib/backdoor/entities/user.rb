# frozen_string_literal: true

require "bcrypt"

class User < Hanami::Entity
  include BCrypt

  MASTER = "master"

  PASSPHRASE_MINIMUM_SIZE = 16

  def match_external_user_id?(external_user_id)
    self.external_user_id == external_user_id
  end

  def passphrase_match?(passphrase)
    Password.new(self.passphrase) == passphrase
  end

  def passphrase_must_match!(passphrase)
    raise Backdoor::Errors::PassphraseConfirmationError unless passphrase_match?(passphrase)
  end

  def github_token!
    Backdoor::Services::Security.new.decrypt(self.github_token)
  end

  def is_user_complete?
    !self.passphrase.nil? && !self.github_token.nil? && !self.git_commit_email.nil?
  end

  def serialize
    {
      id: self.uuid,
      is_user_complete: self.is_user_complete?,
      email: self.email,
      git_commit_email: self.git_commit_email
    }
  end
end
