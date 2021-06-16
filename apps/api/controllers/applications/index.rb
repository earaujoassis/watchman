module Api
  module Controllers
    module Applications
      class Index
        include Api::Action

        def call(params)
          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: "unknown user" } if user.nil?
          applications = ApplicationRepository.new.from_user_with_actions(user)
          self.body = { user: { applications: applications.map(&:serialize) } }.to_json
        end
      end
    end
  end
end
