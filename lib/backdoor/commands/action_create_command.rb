# frozen_string_literal: true

require_relative "./base_command"

class Backdoor::Commands::ActionCreateCommand < Backdoor::Commands::BaseCommand
  def initialize(params:, application:, credential:)
    super(params: params)
    @application = application
    @credential = credential
  end

  def perform
    validate
    raise Backdoor::Errors::CommandError.new("cannot create action", @errors) unless valid?
    repository = ActionRepository.new
    @params[:credential_id] = @credential.id
    @params[:application_id] = @application.id
    @params[:payload] = @params[:payload].to_json.to_s
    @params[:current_status] = Action::CREATED
    begin
      action = repository.create(@params)
    rescue PG::Error
      raise Backdoor::Errors::CommandError, "cannot create action: database error"
    end
    action
  end

  def validate
    validator(Action.valid_type?(@params[:type]), :type, "is not valid")
    validator(validate_managed_realm, :managed_realm, "is not valid")
    validator(validate_managed_project, :managed_project, "is not valid")
    validator(validate_commit_hash, :commit_hash, "is not valid")
  end

  private

  def validate_managed_realm
    @application.managed_realm == @params[:payload][:managed_realm]
  end

  def validate_managed_project
    @application.managed_projects.split(",").include?(@params[:payload][:managed_project])
  end

  def validate_commit_hash
    return true if @params[:payload][:commit_hash].nil?
    (@params[:payload][:commit_hash] =~ /^\w{5,13}$/) == 0
  end
end
