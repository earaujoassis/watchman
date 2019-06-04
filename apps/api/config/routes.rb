# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

post '/user', to: 'user#create'
get '/user', to: 'user#index'
patch '/user/:id', to: 'user#update'
get '/user/:id/repos', to: 'user#repos'
