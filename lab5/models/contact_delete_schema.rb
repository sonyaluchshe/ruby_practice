# frozen_string_literal: true

require 'dry-schema'

ContactDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
