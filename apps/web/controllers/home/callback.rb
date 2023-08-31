# frozen_string_literal: true

module Web::Controllers::Home
  class Callback
    include Web::Action

    params do
      optional(:code).filled(:str?)
      optional(:scope).filled(:str?)
      optional(:state).filled(:str?)
      optional(:error).filled(:str?)
    end

    def call(params)
      if has_error? && !has_code?
        redirect_to(routes.root_path)
        return
      end

      oauth_service = Backdoor::Services::OAuth.factory
      repository = UserRepository.new
      begin
        oauth_service.retrieve_token(code: params[:code])
        token = oauth_service.token
        raw_user_introspection = oauth_service.retrieve_user_data
      rescue Backdoor::Services::OAuth::Error => e
        redirect_to(routes.root_path)
        return
      end

      external_user = raw_user_introspection[:user]
      begin
        internal_user = Backdoor::Commands::UserIdentityProvisionCommand.new(params: {
          email: external_user[:email],
          external_user_id: external_user[:public_id],
        }).perform
      rescue Backdoor::Errors::MasterUserAlreadyCreated => e
        internal_user = repository.master_user
        unless internal_user.match_external_user_id?(external_user[:public_id])
          # TODO another master user was already created with differnt public_id
        end
      end

      internal_session = Backdoor::Commands::SessionCreateCommand.new(params: {
        user_id: internal_user.id,
        access_token: token.token,
        refresh_token: token.refresh_token
      }).perform

      session[:watchman_session_uuid] = internal_session.uuid

      redirect_to(routes.root_path)
    end

    private

    def has_error?
      !params[:error].nil? && !params[:error]&.empty?
    end

    def has_code?
      !params[:code].nil? && !params[:code]&.empty?
    end
  end
end
