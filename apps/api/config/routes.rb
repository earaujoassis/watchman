# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get "/health-check", to: "health_check#index"

namespace "users" do
  post "/", to: "users#create"
  get "/", to: "users#index"
  get "/:id/credentials", to: "credentials#index"
  post "/:id/credentials", to: "credentials#create"
  put "/:user_id/credentials/:credential_id/inactivate", to: "credentials#inactivate"
  patch "/:id", to: "users#update"
  get "/:id/repositories", to: "repositories#index"
  post "/:id/applications", to: "applications#create"
  get "/:id/applications", to: "applications#index"
end

namespace "servers" do
  get "/", to: "servers#index"
  put "/notify", to: "servers#notify"
  post "/reports", to: "reports#create"
  put "/reports/:id", to: "reports#update"
  get "/:id/reports", to: "reports#index"
  get "/:server_id/reports/:report_id", to: "reports#show"
end

namespace "applications" do
  get "/:id/configuration_file", to: "applications#show"
  post "/:id/actions", to: "actions#create"
  put "/:application_id/actions/:action_id/executor", to: "actions#update"
end

namespace "executors" do
  get "/actions", to: "executors#actions_index"
  get "/actions/:id", to: "executors#actions_show"
  put "/actions/:id", to: "executors#actions_update"
end
