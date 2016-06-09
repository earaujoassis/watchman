require 'uri'
require 'whois'

module Watchman
  module WHOIS
    class << self
      def verify_uri(uri)
        uri = URI.parse(uri)
        client = Whois::Client.new(timeout: 100)
        record = client.lookup(uri.host)
        {
          created_on: record.properties[:created_on],
          updated_on: record.properties[:updated_on],
          expires_on: record.properties[:expires_on],
        }
      end
    end
  end
end
