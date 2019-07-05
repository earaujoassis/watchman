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
get "/servers", to: "server#list"
