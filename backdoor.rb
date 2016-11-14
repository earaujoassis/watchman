require 'rubygems'
require 'bundler'
Bundler.require
$: << File.expand_path('../', __FILE__)

require 'dotenv'
Dotenv.load

require 'sinatra/base'
require 'json'
require 'lib/backdoor'

module Backdoor
  class App < Backdoor::Application
    configure do
      disable :method_override
      disable :static

      set :sessions,
          httponly:     true,
          secure:       true,
          expire_after: 31557600, # 1 year
          secret:       ENV['SESSION_SECRET']
    end

    use Rack::Deflater
    use Backdoor::Routes::Webhook
  end
end
