module Api
  module Controllers
    module User
      class Repos
        include Api::Action

        def call(params)
          self.format = :json

          repository = UserRepository.new
          user = repository.find(params[:id])
          halt 404, { error: 'unknown user' } if user.nil?
          github_service = Backdoor::Services::GitHub.new user.github_token
          begin
            repos = github_service.repos
            self.body = { user: { repos: repos.map(&:to_hash) } }.to_json
          rescue Backdoor::Services::GitHub::Error => e
            halt 500, { error: e.to_s }.to_json
          end
        end
      end
    end
  end
end
