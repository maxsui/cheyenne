<% @seance_observable.observable.candidates.each do |candidate| %>
$('#seance_observable_<%= @seance_observable.id %>').removeClass('noted-<%= seance_customer_observable_note_label(candidate) %>');
<% end %>
$('#seance_observable_<%= @seance_observable.id %>').removeClass('noted-ignored');

$('#seance_observable_<%= @seance_observable.id %>').addClass('noted-<%= seance_customer_observable_note_label(@seance_observable) %>')
