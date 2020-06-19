# frozen_string_literal: true

# Main route
class NotebookApplication
  path :contacts, '/contacts'
  path :contact_new, '/contacts/new'
  path :contact_event, '/contacts/event'
  path Contact do |contact, action|
    if action
      "/contacts/#{contact.id}/#{action}"
    else
      "/contacts/#{contact.id}"
    end
  end

  hash_branch('contacts') do |r|
    append_view_subdir('contacts')
    set_layout_options(template: '../views/layout')

    r.is do
      @params = DryResultFormeWrapper.new(ContactFilterFormSchema.call(r.params))
      @filtered_contacts = if @params.success?
                             opts[:contacts].filter(@params[:dob])
                           else
                             opts[:contacts].all_contacts
                           end
      view('contacts')
    end

    r.on Integer do |contact_id|
      @contact = opts[:contacts].contact_by_id(contact_id)
      next if @contact.nil?

      r.is do
        view('contact')
      end

      r.on 'edit' do
        r.get do
          @parameters = @contact.to_h
          view('contact_edit')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(ContactFormSchema.call(r.params))
          if @parameters.success?
            opts[:contacts].update_contact(@contact.id, @parameters)
            r.redirect(path(@contact))
          else
            view('contact_edit')
          end
        end
      end

      r.on 'delete' do
        r.get do
          @parameters = {}
          view('contact_delete')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(ContactDeleteSchema.call(r.params))
          if @parameters.success?
            opts[:contacts].delete_contact(@contact.id)
            r.redirect(contacts_path)
          else
            view('contact_delete')
          end
        end
      end
    end

    r.on 'new' do
      r.get do
        @parameters = {}
        view('contact_new')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(ContactFormSchema.call(r.params))
        if @parameters.success?
          contact = opts[:contacts].add_contact(@parameters)
          r.redirect(path(contact))
        else
          view('contact_new')
        end
      end
    end

    r.on 'event' do
      r.get do
        @parameters = {}
        view('contact_event')
      end

      r.post do
        @parameters = DryResultFormeWrapper.new(ContactFormSchema.call(r.params))
        if @parameters.success?
          contact = opts[:contacts].invite_contact(@parameters)
          r.redirect(path(contact))
        else
          view('contact_event')
        end
      end
    end
  end
end
