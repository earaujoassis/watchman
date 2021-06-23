# frozen_string_literal: true

require "base64"
require "digest"
require "openssl"

class Backdoor::Services::Security
  class Error < StandardError; end

  def initialize
    @key = nil
    @version = nil
  end

  def key=(value)
    validate!(:key, value, 64)
    @key = value
  end

  def key
    @key ||= begin
      value = ENV["SECRET_KEY"]
      validate!(:key, value, 64)
      value
    end
  end

  def version=(value)
    validate!(:version, value, 16)
    @version = value
  end

  def version
    @version ||= begin
      value = ENV["SECRET_KEY_VERSION"]
      validate!(:version, value, 16)
      value
    end
  end

  def encrypt(data)
    cipher = OpenSSL::Cipher.new("AES-256-CBC")
    cipher.encrypt
    cipher.key = Digest::SHA256.digest(key)
    version + Base64.encode64(cipher.update(data) + cipher.final)
  end

  def decrypt(data)
    encrypted_data = retrieve_encrypted_data!(data)
    cipher = OpenSSL::Cipher.new("AES-256-CBC")
    cipher.decrypt
    cipher.padding = 0
    cipher.key = Digest::SHA256.digest(key)
    cipher.update(encrypted_data) + cipher.final
  end

  private

  def retrieve_encrypted_data!(data)
    raise Error, "version mismatch; cannot decrypt" unless data.start_with?(version)
    data = data.gsub(/^#{version}/, "")
    Base64.decode64(data)
  end

  def validate!(attr_name, value, minimum_size)
    if value.nil? || !value.kind_of?(String) || value&.bytesize < minimum_size
      raise Error, "#{attr_name} is invalid and succeptable to security breach"
    end
  end
end
