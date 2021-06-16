# frozen_string_literal: true

module Api
  module Controllers
    module Credentials
      class Create
        include Api::Action

        def call(params)
          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: "unknown user" }.to_json if user.nil?
          credential = repository.add_credential(user)

          content = "client_key,client_secret\n#{credential.client_key},#{credential.client_secret}\n"
          self.headers.merge!({
            "Content-Type" => "text/csv",
            "Content-Disposition" => 'attachment; filename="credentials.csv"',
            "Content-Length" => content.bytesize.to_s
          })
          self.body = content
        end
      end
    end
  end
end
