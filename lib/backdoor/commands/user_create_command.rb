# frozen_string_literal: true

require_relative "../services/security"

class Backdoor::Commands::UserCreateCommand < Backdoor::Commands::BaseCommand
  def initialize(params:)
    super(params: params)
  end

  def perform
    repository = UserRepository.new
    encryptor = Backdoor::Services::Security.new
    @params[:github_token] = encryptor.encrypt(@params[:github_token])
    repository.create_master_user(@params)
    repository.master_user
  end
end
