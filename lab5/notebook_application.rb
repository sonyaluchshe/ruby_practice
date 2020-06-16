# frozen_string_literal: true

require 'forme'
require 'roda'

require_relative 'models'

# The main class of "Notebook the App"
class NotebookApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :render
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:contacts] = ContactList.new(
    [
      Contact.new(
        id: 7,
        lname: 'Дранкер',
        fname: 'Мария Геула',
        cell_number: '8(999)-999-99-99',
        address: 'проспект Толбухина, 43, 46',
        dob: '2001-18-09',
        sex: 'женщина',
        relation: 'подружка'
      ),
      Contact.new(
        id: 13,
        lname: 'Романова',
        fname: 'Ирина',
        patronymic: 'Юрьевна',
        home_number: '21-89-88',
        cell_number: '8(903)-825-54-47',
        address: 'проспект Толбухина, 26, 63',
        dob: '1970-29-09',
        sex: 'женщина',
        relation: 'мама'
      )
    ]
  )

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/contacts'
    end

    r.on 'contacts' do
      r.is do
        @contacts = opts[:contacts].all_contacts
        view('contacts')
      end

      r.on Integer do |contact_id|
        @contact = opts[:contacts].contact_by_id(contact_id)
        next if @contact.nil?

        view('contact')
      end
    end
  end
end
