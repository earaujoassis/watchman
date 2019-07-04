module Backdoor
  module Ws
    module Messages
      CONNECTED_MESSAGE = {
        type: 'control',
        message: 'connected'
      }.to_json.to_s.freeze

      SYNC_MESSAGE = {
        type: 'control',
        reason: 'keep-connection',
        message: Time.now.to_i
      }.to_json.to_s.freeze
    end
  end
end
