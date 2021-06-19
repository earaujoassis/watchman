# frozen_string_literal: true

require_relative "./base_command"

class Backdoor::Commands::ActionUpdateCommand < Backdoor::Commands::BaseCommand
  def initialize(params:, action:)
    super(params: params)
    @action = action
  end

  def perform
    validate
    raise Backdoor::Errors::ActionError.new("cannot update action", @errors) unless valid?
    repository = ActionRepository.new
    begin
      repository.executor_update(@action, @params)
    rescue PG::Error
      raise Backdoor::Errors::ActionError, "cannot update action: database error"
    end
  end

  def validate
    validator(@action.valid_status?(@params[:current_status]), :current_status, "is not valid")
  end
end
