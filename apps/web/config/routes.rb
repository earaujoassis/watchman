# frozen_string_literal: true

# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

DEFAULT_ROUTE = "home#index"

get "/dashboard", to: DEFAULT_ROUTE
get "/configuration", to: DEFAULT_ROUTE
get "/configuration/credentials", to: DEFAULT_ROUTE
get "/projects", to: DEFAULT_ROUTE
get "/applications", to: DEFAULT_ROUTE
get "/servers", to: DEFAULT_ROUTE
get "/reports", to: DEFAULT_ROUTE
get "/reports/:report_id/from/:server_id", to: DEFAULT_ROUTE
get "/oauth2/callback", to: "home#callback"
get "/signin", to: "home#signin"
get "/signout", to: "home#signout"

redirect "/", to: "/dashboard"

root to: "home#index"
