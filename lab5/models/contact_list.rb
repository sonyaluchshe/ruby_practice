# frozen_string_literal: true

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
end
