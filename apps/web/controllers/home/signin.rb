# frozen_string_literal: true

module Web::Controllers::Home
  class Signin
    include Web::Action

    def call(params)
      redirect_to(Backdoor::Services::OAuth.factory.authorize_url)
    end
  end
end
