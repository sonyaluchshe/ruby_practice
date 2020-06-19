# frozen_string_literal: true

require 'dry-schema'

require_relative 'contact_sex'
require_relative 'schema_types'

ContactFormSchema = Dry::Schema.Params do
  required(:lname).maybe(SchemaTypes::StrippedString)
  required(:fname).filled(SchemaTypes::StrippedString)
  required(:patronymic).maybe(SchemaTypes::StrippedString)
  # required(:home_number).maybe(SchemaTypes::StrippedString, format?: /^(\d{2}-\d{2}-\d{2})$/)
  required(:home_number).maybe(:integer)
  required(:cell_number).filled(:integer)
  required(:address).maybe(SchemaTypes::StrippedString)
  required(:dob).maybe(:date)
  required(:sex).maybe(SchemaTypes::StrippedString, included_in?: ContactSex.all_sexes)
  required(:relation).filled(SchemaTypes::StrippedString)
end
