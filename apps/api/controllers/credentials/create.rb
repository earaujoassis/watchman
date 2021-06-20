# frozen_string_literal: true

module Api
  module Controllers
    module Credentials
      class Create
        include Api::Action

        params do
          required(:id).filled(:str?)
        end

        def call(params)
          repository = UserRepository.new
          user = repository.find!(params[:id])

          command = Backdoor::Commands::CredentialCreateCommand.new(user: user)
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
        end
      end
    end
  end
end
