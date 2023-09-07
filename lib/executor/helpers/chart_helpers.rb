# frozen_string_literal: true

require "yaml"

module Executor
  module ChartHelpers
    class << self
      def load_values(path:)
        @path = path
        @content = YAML.load_file(@path)
      end

      def update_image_tag(tag:, path: ["image", "tag"])
        content = @content.clone
        *head, tail = path
        head.inject(content) { |hash, key| hash[key] }[tail] = "'sanitizeQuote: #{tag}'"
        @content = content
      end

      def save_values
        File.open(@path, "w") do |f|
          f.puts @content.to_yaml.to_s.gsub("---\n", "").gsub("sanitizeQuote: ", "")
        end
        true
      end
    end
  end
end
