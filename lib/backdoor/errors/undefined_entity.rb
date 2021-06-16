class Backdoor::Errors::UndefinedEntity < StandardError
  def initialize(msg="entity was not found")
    super
  end
end
