# frozen_string_literal: true

module Api::Controllers::Servers
  class Index
    include Api::Action
    include Api::UserAuthentication

    def call(params)
      repository = ServerRepository.new
      self.body = { servers: repository.all.map(&:serialize) }
    end
  end
end
