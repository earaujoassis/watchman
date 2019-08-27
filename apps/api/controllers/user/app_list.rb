module Api
  module Controllers
    module User
      class AppList
        include Api::Action

        def call(params)
          self.format = :json

          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: "unknown user" } if user.nil?
          applications = ApplicationRepository.new.from_user_with_actions(user)
          self.body = { user: { apps: applications.map(&:serialize) } }.to_json
        end
      end
    end
  end
end
