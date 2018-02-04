module SeanceCustomerObservablesHelper

  def link_to_note_seance_customer_observable(seance_observable, note, label = nil)
    label ||= note.to_s
    path = note_seance_seance_customer_path(seance_observable.seance_customer.seance, seance_observable.seance_customer)
    link_to label, path, data: { remote: true, params: {note: note, seance_customer_observable_id: seance_observable }.to_param }, method: :put
  end

  def seance_customer_observable_note_label(seance_customer_observable_or_note)
    note =
      if seance_customer_observable_or_note.respond_to?(:note)
        seance_customer_observable_or_note.note
      else
        seance_customer_observable_or_note
      end

    note == -1 ? 'ignored' : note.to_s
  end

end
