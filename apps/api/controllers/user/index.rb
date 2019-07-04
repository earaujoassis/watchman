module Api
  module Controllers
    module User
      class Index
        include Api::Action

        def call(params)
          self.format = :json
          user = UserRepository.new.master_user
          self.body = { user: user&.serialize }.to_json
        end
      end
    end
  end
end
