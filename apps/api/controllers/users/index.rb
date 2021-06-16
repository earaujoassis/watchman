# frozen_string_literal: true

module Api
  module Controllers
    module Users
      class Index
        include Api::Action

        def call(params)
          user = UserRepository.new.master_user
          self.body = { user: user&.serialize }.to_json
        end
      end
    end
  end
end
