require 'uri'
require 'net/https'
require 'openssl'

module Watchman
  module Certificate
    class << self
      def verify_uri(uri)
        cert = nil
        uri = URI.parse(uri)
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_NONE
        https.start{|h| cert = h.peer_cert}
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
