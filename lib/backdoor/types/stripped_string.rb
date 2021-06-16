require "dry-types"

module Types
  include Dry::Types.module

  StrippedString = Types::String.constructor(&:strip)
end
