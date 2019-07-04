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
      end

      def call(env)
        if Faye::WebSocket.websocket?(env)
          ws = Faye::WebSocket.new(env, nil, { extensions: [ PermessageDeflate ] })

          ws.on :open do |event|
            p [:open, ws.object_id]
            @@clients << ws
            ws.send("Connected")
          end

          ws.on :message do |event|
            p [:message, event.data]
          end

          ws.on :close do |event|
            p [:close, ws.object_id, event.code, event.reason]
            @@clients.delete(ws)
            ws = nil
          end

          ws.rack_response
        else
          @app.call(env)
        end
      end
    end
  end
end
