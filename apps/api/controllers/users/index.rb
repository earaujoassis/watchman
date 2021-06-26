# frozen_string_literal: true

module Api::Controllers::Users
  class Index
    include Api::Action

    def call(params)
      user = UserRepository.new.master_user
      self.body = { user: user&.serialize }
    end
  end
end
