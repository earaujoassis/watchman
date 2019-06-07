module Api
  module Controllers
    module User
      class Credentials
        include Api::Action

        def call(params)
          self.format = :json

          repository = UserRepository.new
          repository.generate_credentials(params[:id])
          user = repository.find(params[:id])

          content = "client_key,client_secret\n#{user.client_key},#{user.client_secret}\n"
          self.headers.merge!({
            'Content-Type' => 'text/csv',
            'Content-Disposition' => 'attachment; filename="credentials.csv"',
            'Content-Length' => content.bytesize.to_s
          })
          self.body = content
        end
      end
    end
  end
end
