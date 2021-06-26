# frozen_string_literal: true

require "json"

module Helpers
  module Fixtures
    class << self
      SUPPORT_ROOT = File.expand_path("../", __dir__)

      def load_json(name:)
        json_file = File.read(File.join(SUPPORT_ROOT, "data", name + ".json"))
        JSON.generate(JSON.parse(json_file))
      end
    end
  end
end
