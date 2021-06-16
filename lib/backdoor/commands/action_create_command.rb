class Backdoor::Commands::ActionCreateCommand
  @@actions_valid_types = %w(git_ops_updater)

  def initialize(params:, application:, credential:)
    @params = params
    @application = application
    @credential = credential
    @valid = nil
    @errors = Hash.new
  end

  def perform
    validate
    raise Backdoor::Errors::ActionError, "cannot create action: #{@errors.to_s}" unless valid?
    repository = ActionRepository.new
    @params[:credential_id] = @credential.id
    @params[:application_id] = @application.id
    @params[:payload] = @params[:payload].to_json.to_s
    @params[:current_status] = Action::CREATED
    begin
      repository.create(@params)
    rescue PG::Error
      raise Backdoor::Errors::ActionError, "cannot create action: database error"
    end
  end

  def validate
    validator(
      @@actions_valid_types.include?(@params[:type]), :type, "is not valid"
    )
    validator(
      @application.managed_realm == @params[:payload][:managed_realm], :managed_realm, "is not valid"
    )
    validator(@application.managed_projects.split("\n").include?(
      @params[:payload][:managed_project]), :managed_project, "is not valid"
    )
  end

  def valid?
    return false if @valid.nil?
    @valid
  end

  private

  def validator(rule, attr, message)
    @valid = rule if @valid.nil?
    @errors[attr] = message unless rule
    @valid = rule && @valid
  end
end
