module SceanceCustomerObservablesHelper

  def link_to_note_sceance_customer_observable(sceance_observable, note, label = nil)
    label ||= note.to_s
    path = note_sceance_sceance_customer_path(sceance_observable.sceance_customer.sceance, sceance_observable.sceance_customer)
    link_to label, path, data: { remote: true, params: {note: note, sceance_customer_observable_id: sceance_observable }.to_param }, method: :put
  end

  def sceance_customer_observable_note_label(sceance_customer_observable_or_note)
    note =
      if sceance_customer_observable_or_note.respond_to?(:note)
        sceance_customer_observable_or_note.note
      else
        sceance_customer_observable_or_note
      end

    note == -1 ? 'ignored' : note.to_s
  end

end
