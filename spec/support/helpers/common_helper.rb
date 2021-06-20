# frozen_string_literal: true

require "base64"

module Helpers
  module Common
    def clear_repositories
      ActionRepository.new.clear
      ApplicationRepository.new.clear
      CredentialRepository.new.clear
      ReportRepository.new.clear
      ServerRepository.new.clear
      UserRepository.new.clear
    end

    def authorization_code(client_key, client_secret)
      "Bearer #{Base64.encode64("#{client_key}:#{client_secret}")}"
    end
  end
end
