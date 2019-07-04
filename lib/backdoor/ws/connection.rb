# Module used for WebSocket communication
#
# So far, no specific protocol is defined. Missing requirements:
# - Implement the Action Cable protocol over WebSocket
# - Have specific protocol/channels for each communication channel
# - Faye's ping solution is not currently working
#
module Backdoor
  module Ws
    class Connection
      KEEPALIVE_TIME = 15

      @@clients = []

      class << self
        def broadcast(message)
          @@clients.each { |ws| ws.send(message.to_s) }
        end
      end

      def initialize(app)
        @app = app
        @logger = Hanami::Logger.new('backdoor')
      end

      def call(env)
        if Faye::WebSocket.websocket?(env)
          ws = Faye::WebSocket.new(env, nil, { extensions: [ PermessageDeflate ] })

          ws.on :open do |event|
            @@clients << ws
            ws.send("Connected")
            @logger.info("WebSocket connection open for object ID #{ws.object_id}")
          end

          ws.on :message do |event|
            @logger.info("WebSocket connection received a message: #{event.data}")
          end

          ws.on :close do |event|
            @@clients.delete(ws)
            ws = nil
            @logger.info("WebSocket connection closed for object ID #{ws.object_id}; code=#{event.code} reason=#{event.reason}")
          end

          ws.rack_response
        else
          @app.call(env)
        end
      end
    end
  end
end
