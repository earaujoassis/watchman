# frozen_string_literal: true

require_relative "../services/security"

class Backdoor::Commands::UserCompleteCreateCommand < Backdoor::Commands::BaseCommand
  def initialize(params:)
    super(params: params)
  end

  def perform
    repository = UserRepository.new
    user = repository.master_user
    repository.update_user(user.uuid, @params.slice(:github_token, :passphrase))
    repository.master_user
  end
end
