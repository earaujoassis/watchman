# frozen_string_literal: true

require "base64"

class Backdoor::Services::Sidecar
  def initialize(request)
    @request = request
  end

  def same_pod?
    return true unless ENV["WATCHMAN_DISABLE_AUTHENTICATION"].nil?
    @request.ip == "127.0.0.1"
  end
end
