# frozen_string_literal: true

require 'psych'
require_relative 'contact_list'
require_relative 'contact'

# Data storage
class Store
  attr_reader :contact_list

  DATA_STORE = File.expand_path('../db/data.yaml', __dir__)

  def initialize
    @contact_list = ContactList.new
    read_data
    at_exit { write_data }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:contact_list].each do |raw_contact|
      @contact_list.add_real_contact(Contact.new(**raw_contact))
    end
  end

  def write_data
    raw_contacts = @contact_list.all_contacts.map(&:to_h)
    yaml_data = Psych.dump({
                             contact_list: raw_contacts
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
