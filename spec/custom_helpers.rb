# frozen_string_literal: true

module Helpers
  def clear_repositories
    ActionRepository.new.clear
    ApplicationRepository.new.clear
    CredentialRepository.new.clear
    ReportRepository.new.clear
    ServerRepository.new.clear
    UserRepository.new.clear
  end
end
