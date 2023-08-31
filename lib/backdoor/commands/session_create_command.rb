# frozen_string_literal: true

class Backdoor::Commands::SessionCreateCommand < Backdoor::Commands::BaseCommand
  def initialize(params:)
    super(params: params)
  end

  def perform
    repository = SessionRepository.new
    repository.create(@params.slice(:user_id, :access_token, :refresh_token))
  end
end
