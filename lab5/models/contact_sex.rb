# frozen_string_literal: true

# The container for the sexes
module ContactSex
  FEMALE = 'женский'
  MALE = 'мужской'
  OTHER = 'другой'

  def self.all_sexes
    [
      FEMALE, MALE, OTHER
    ]
  end
end
