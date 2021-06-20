# frozen_string_literal: true

module Api
  module Controllers
    module Applications
      class Index
        include Api::Action

        params do
          required(:id).filled(:str?)
        end

        def call(params)
          repository = UserRepository.new
          user = repository.find!(params[:id])
          applications = ApplicationRepository.new.from_user_with_actions(user)
          self.body = { user: { applications: applications.map(&:serialize) } }
        rescue Backdoor::Errors::UndefinedEntity => e
          halt 404, { error: e.message }
        end
      end
    end
  end
end
