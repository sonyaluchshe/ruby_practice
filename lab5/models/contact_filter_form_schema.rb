# frozen_string_literal: true

require 'dry-schema'

ContactFilterFormSchema = Dry::Schema.Params do
  optional(:dob).maybe(:date)
end
