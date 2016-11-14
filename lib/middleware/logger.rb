module Backdoor
  module Middleware
    class Logger
      def initialize app
        @app = app
      end

      def call env
        logger = Backdoor::Logger.instance
        request = Rack::Request.new env
        logger.info "Payload received IP: #{request.ip}"
        logger.info "Payload DATA: #{request.body.read}"
        status, headers, response = @app.call env
        dir = Backdoor::Config.for 'BD_REPO_DIR'
        upstream = Backdoor::Config.for 'BD_UPSTREAM'
        branch = Backdoor::Config.for 'BD_BRANCH'
        if status == 200
          logger.info "Payload accepted"
          logger.info "#{dir} '#{upstream}/#{branch}' successfully pulled"
        elsif status == 400..505
          logger.warn "ERROR: #{env['sinatra.error'].message}"
        end
        [status, headers, response]
      end
    end
  end
end
