module Api
  module Controllers
    module User
      class Index
        include Api::Action

        def call(params)
          self.format = :json
          self.body = { user: UserRepository.new.master_user.serialize }.to_json
        end
      end
    end
  end
end
