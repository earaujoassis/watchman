# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

post '/user', to: 'user#create'
get '/user', to: 'user#index'
patch '/user/:id', to: 'user#update'
get '/user/:id/repositories', to: 'user#repos'
post '/user/:id/applications', to: 'user#app_create'
get '/user/:id/applications', to: 'user#app_index'
