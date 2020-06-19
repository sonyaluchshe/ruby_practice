# frozen_string_literal: true

require 'dry-types'

# Shema validation types
module SchemaTypes
  include Dry.Types

  StrippedString = self::String.constructor(&:strip)
end
