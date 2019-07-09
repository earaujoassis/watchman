# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

post "/users", to: "user#create"
get "/users", to: "user#index"
get "/users/:id/credentials", to: "user#credentials"
patch "/users/:id", to: "user#update"
get "/users/:id/repositories", to: "user#repos"
post "/users/:id/applications", to: "user#app_create"
get "/users/:id/applications", to: "user#app_list"

put "/servers/notify", to: "server#notify"
post "/servers/report", to: "server#report_create"
put "/servers/report/:id", to: "server#report_update"
get "/servers", to: "server#list"
get "/servers/:id/reports", to: "server#report_list"
get "/servers/:server_id/reports/:report_id", to: "server#report_view"
