require_relative "../authentication"

module Api
  module Controllers
    module Actions
      class Update
        include Api::Action
        include Api::Authentication

        params do
          required(:action).schema do
            required(:type).filled(:str?)
            optional(:description).filled(:str?)
            required(:payload).schema do
              required(:managed_realm).filled(:str?)
              required(:managed_project)
            end
          end
        end

        def call(params)
          status 405, { message: "not implemented yet" }.to_json
        end
      end
    end
  end
end
