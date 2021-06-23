# frozen_string_literal: true

require_relative "../services/security"

class Backdoor::Commands::UserUpdateCommand < Backdoor::Commands::BaseCommand
  def initialize(params:, user_id:)
    super(params: params)
    @user_id = user_id
  end

  def perform
    repository = UserRepository.new
    user = repository.find!(@user_id)
    user.passphrase_must_match!(@params[:passphrase_confirmation])

    encryptor = Backdoor::Services::Security.new
    @params[:github_token] = encryptor.encrypt(@params[:github_token])
    repository.update_user(@user_id, @params.slice(:github_token))
    repository.master_user
  end
end
