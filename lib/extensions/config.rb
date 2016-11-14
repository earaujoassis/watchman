require 'singleton'

module Backdoor
  class Config
    def self.for key
      ENV[key]
    end
  end
end
