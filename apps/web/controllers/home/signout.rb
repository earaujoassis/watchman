# frozen_string_literal: true

module Web::Controllers::Home
  class Signout
    include Web::Action

    def call(params)
      session[:watchman_session_uuid] = nil
      redirect_to(routes.root_path)
    end
  end
end
