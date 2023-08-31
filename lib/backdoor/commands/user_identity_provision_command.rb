# frozen_string_literal: true

require_relative "../services/security"

class Backdoor::Commands::UserIdentityProvisionCommand < Backdoor::Commands::BaseCommand
  def initialize(params:)
    super(params: params)
  end

  def perform
    repository = UserRepository.new
    user = repository.master_user
    raise Backdoor::Errors::MasterUserAlreadyCreated if !user.nil?

    repository.create_master_user(@params.slice(:email, :external_user_id))
    repository.master_user
  end
end
