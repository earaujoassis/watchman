# frozen_string_literal: true

module Web::Controllers::Home
  class Callback
    include Web::Action

    params do
      required(:code).filled(:str?)
      optional(:scope).filled(:str?)
      optional(:state).filled(:str?)
    end

    def call(params)
      redirect_to(routes.root_path)
    end
  end
end
