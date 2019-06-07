module Api
  module Controllers
    module User
      class Index
        include Api::Action

        def call(params)
          self.format = :json
          user = UserRepository.new.master_user&.serialize
          self.body = { user: user }.to_json
        end
      end
    end
  end
end
