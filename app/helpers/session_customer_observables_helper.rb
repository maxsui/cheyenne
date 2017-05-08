module SessionCustomerObservablesHelper

  def link_to_note_session_customer_observable(session_observable, note, label = nil)
    label ||= note.to_s
    path = note_session_session_customer_path(session_observable.session_customer.session, session_observable.session_customer)
    link_to label, path, data: { remote: true, params: {note: note, session_customer_observable_id: session_observable }.to_param }, method: :put
  end

  def session_customer_observable_note_label(session_customer_observable_or_note)
    note =
      if session_customer_observable_or_note.respond_to?(:note)
        session_customer_observable_or_note.note
      else
        session_customer_observable_or_note
      end

    note == -1 ? 'ignored' : note.to_s
  end

end
