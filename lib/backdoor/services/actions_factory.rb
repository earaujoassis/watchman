class Backdoor::Services::ActionsFactory
  class << self
    def create_deployment_action(application)
      repository = ActionRepository.new
      repository.create({
        application_id: application.id,
        type: Action::DEPLOY.to_s,
        description: "#{Action::DEPLOY} #{Action::ACTION_REASON[Action::DEPLOY]}",
        payload: {
          type: Action::DEPLOY.to_s,
          project_full_name: application.full_name,
          process_name: application.process_name,
          configuration_file_name: application.configuration_file_name,
          application_id: application.uuid
        }.to_json.to_s,
        current_status: Action::CREATED
      })
    end
  end
end
