require "uri"
require "net/http"

module Watchman
  module Health
    class << self
      def request(uri)
        uri = URI.parse(uri)
        request = Net::HTTP.new(uri.host, uri.port)
        request.use_ssl = true if uri.scheme == "https"
        start_time = Time.now
        response = request.head("/")
        elapsed_time = Time.now - start_time
        status_code = response.code.to_i
        {
          status_code: status_code,
          elapsed_time: elapsed_time,
          response: response,
        }
      end

      def verify_uri(uri)
        response = self.request(uri)
        status_code = response[:status_code]
        while status_code == 301 || status_code == 302
          location = response[:response]["location"]
          response = self.request(location)
          status_code = response[:status_code]
        end
        {
          status_code: status_code,
          elapsed_time: response[:elapsed_time],
        }
      end
    end
  end
end
