# frozen_string_literal: true

require 'erb'

require_relative 'contact'

# Contains all of the contacts
class ContactList
  def initialize(contacts = [])
    @contacts = contacts.map do |contact|
      [contact.id, contact]
    end.to_h
  end

  def all_contacts
    @contacts.values
  end

  def contact_by_id(id)
    @contacts[id]
  end

  def add_contact(parameters)
    contact_id = if @contacts.empty?
                   1
                 else
                   @contacts.keys.max + 1
                 end
    @contacts[contact_id] = Contact.new(id: contact_id, **parameters.to_h)
    @contacts[contact_id]
  end

  def add_real_contact(contact)
    @contacts[contact.id] = contact
  end

  def update_contact(id, parameters)
    contact = @contacts[id]
    contact.home_number = parameters[:home_number]
    contact.cell_number = parameters[:cell_number]
    contact.address = parameters[:address]
    contact.relation = parameters[:relation]
  end

  def filter(date)
    @contacts.select do |contact|
      next if date && !date.nil? && !(contact.dob.mon - date.mon - 1)

      true
    end
  end

  def delete_contact(id)
    @contacts.delete(id)
  end
end
