require 'uri'
require 'net/https'
require 'openssl'

module Watchman
  module Certificate
    class << self
      def verify_uri(uri)
        cert = nil
        uri = URI.parse(uri)
        request = Net::HTTP.new(uri.host, uri.port)
        request.use_ssl = true if uri.scheme == 'https'
        request.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request.start{|h| cert = h.peer_cert}
        {
          subject: cert.subject.to_s,
          serial: cert.serial.to_s,
          issuer: cert.issuer.to_s,
          issued_at: cert.not_before,
          expire_at: cert.not_after,
        }
      end
    end
  end
end
