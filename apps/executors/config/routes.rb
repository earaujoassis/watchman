# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get "/actions", to: "actions#index"
get "/actions/:id", to: "actions#show"
put "/actions/:id", to: "actions#update"
get "/users", to: "users#index"
