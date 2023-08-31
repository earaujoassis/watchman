# frozen_string_literal: true

require "base64"

class Backdoor::Services::UserAuthentication
  def initialize(session)
    @session = session
  end

  def authentic_user?
    repository = SessionRepository.new
    session = repository.find(@session[:watchman_session_uuid])
    return false if session.nil?
    return false unless session.is_active
    # TODO Check if session is also active in earaujoassis/space
    true
  end
end
