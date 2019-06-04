module Api
  module Controllers
    module User
      class Repos
        include Api::Action

        def call(params)
          self.format = :json

          repository = UserRepository.new
          user = repository.find(params[:id])
          github_service =  Backdoor::Services::GitHub.new user.github_token
          repos = github_service.repos
          self.body = { user: { repos: repos.map(&:to_hash) } }.to_json
        end
      end
    end
  end
end
