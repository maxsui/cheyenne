<% @session_observable.observable.candidates.each do |candidate| %>
$('#session_observable_<%= @session_observable.id %>').removeClass('noted-<%= session_customer_observable_note_label(candidate) %>');
<% end %>
$('#session_observable_<%= @session_observable.id %>').removeClass('noted-ignored');

$('#session_observable_<%= @session_observable.id %>').addClass('noted-<%= session_customer_observable_note_label(@session_observable) %>')
