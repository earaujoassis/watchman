# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get '/configuration', to: 'home#index'
get '/projects', to: 'home#index'
get '/applications', to: 'home#index'
get '/servers', to: 'home#index'

redirect '/', to: '/configuration'
