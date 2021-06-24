# frozen_string_literal: true

module Api
  module Controllers
    module Credentials
      class Create
        include Api::Action

        params do
          required(:id).filled(:str?)

          required(:user).schema do
            required(:passphrase_confirmation).filled(:str?)
          end

          optional(:credential).schema do
            optional(:description).filled(:str?)
          end
        end

        def call(params)
          repository = UserRepository.new
          user = repository.find!(params[:id])
          user.passphrase_must_match!(params[:user][:passphrase_confirmation])

          command = Backdoor::Commands::CredentialCreateCommand.new(
            params: params[:credential] || Hash.new,
            user: user
          )
          command.perform

          content = "client_key,client_secret\n#{command.client_key},#{command.client_secret}\n"
          self.headers.merge!({
            "Content-Type" => "text/csv",
            "Content-Disposition" => 'attachment; filename="credentials.csv"',
            "Content-Length" => content.bytesize.to_s
          })
          self.body = content
        rescue Backdoor::Errors::UndefinedEntity => e
          halt 404, { error: e.message }
        rescue Backdoor::Errors::PassphraseConfirmationError => e
          halt 401, { error: e.message }
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
  end
end
