# frozen_string_literal: true

module Api::Controllers::Actions
  class Create
    include Api::Action
    include Api::Authentication

    params do
      required(:id).filled(:str?)

      required(:action).schema do
        required(:type).filled(:str?)
        optional(:description).filled(:str?)
        required(:payload).schema do
          required(:managed_realm).filled(:str?)
          required(:managed_project).filled(:str?)
          optional(:commit_hash).filled(:str?)
        end
      end
    end

    def call(params)
      credential = Backdoor::Services::Authentication.new(request.env).retrieve_credential!
      application = ApplicationRepository.new.find!(params[:id])

      Backdoor::Commands::ActionCreateCommand.new(
        params: params[:action], application: application, credential: credential
      ).perform

      self.body = ""
      self.status = 201
    rescue Backdoor::Errors::UndefinedEntity => e
      halt 404, { error: e.message }
    rescue Backdoor::Errors::CommandError => e
      halt 406, {
        error: {
          message: e.message,
          reasons: e.errors
        }
      }
    end
  end
end
