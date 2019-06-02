# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get '/', to: 'home#index'
get '/configuration', to: 'home#index'
get '/projects', to: 'home#index'
