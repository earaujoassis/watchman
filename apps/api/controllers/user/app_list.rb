module Api
  module Controllers
    module User
      class AppList
        include Api::Action

        def call(params)
          self.format = :json

          repository = UserRepository.new
          user = repository.find_with_applications(params[:id])
          self.body = { user: { apps: user.applications.map(&:serialize) } }.to_json
        end
      end
    end
  end
end
