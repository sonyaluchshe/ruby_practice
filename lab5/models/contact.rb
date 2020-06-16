# frozen_string_literal: true

# Contains information about our pals
Contact = Struct.new(:id,
                     :lname,
                     :fname,
                     :patronymic,
                     :home_number,
                     :cell_number,
                     :address,
                     :dob,
                     :sex,
                     :relation,
                     keyword_init: true)
