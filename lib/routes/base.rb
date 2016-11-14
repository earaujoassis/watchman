module Backdoor
  module Routes
    class Base < Backdoor::Application
      configure do
        set :root, File.expand_path('../../../', __FILE__)

        disable :method_override
        disable :protection
        disable :static

        # Exceptions
        enable :use_code
        set :show_exceptions, :after_handler
      end
    end
  end
end
