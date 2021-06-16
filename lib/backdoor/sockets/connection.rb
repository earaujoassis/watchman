# frozen_string_literal: true

require "concurrent"

# Module used for WebSocket communication
#
# So far, no specific protocol is defined. Missing requirements:
# - Implement the Action Cable protocol over WebSocket
# - Have specific protocol/channels for each communication channel
#
module Backdoor
  module Sockets
    class Connection
      KEEPALIVE_TIME = 10 # seconds

      @@clients = []

      class << self
        def broadcast(message)
          @@clients.each { |ws| ws.send(message.to_s) }
        end
      end

      def initialize(app)
        @app = app
        @beat = nil
        @logger = Hanami::Logger.new("backdoor")
      end

      def call(env)
        if Faye::WebSocket.websocket?(env)
          ws = Faye::WebSocket.new(env, nil, { extensions: [PermessageDeflate] })

          ws.on :open do |event|
            @@clients << ws
            ws.send(Backdoor::Sockets::Messages::CONNECTED_MESSAGE)
            if @beat.nil?
              @beat = Concurrent::TimerTask.new(execution_interval: KEEPALIVE_TIME) do
                Connection.broadcast(Backdoor::Sockets::Messages::SYNC_MESSAGE)
              end
              @beat.execute
            end
            @logger.info("WebSocket connection open for object ID #{ws.object_id}")
          end

          ws.on :message do |event|
            @logger.info("WebSocket connection received a message: #{event.data}; from=#{ws.object_id}")
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
