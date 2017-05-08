<% @sceance_observable.observable.candidates.each do |candidate| %>
$('#sceance_observable_<%= @sceance_observable.id %>').removeClass('noted-<%= sceance_customer_observable_note_label(candidate) %>');
<% end %>
$('#sceance_observable_<%= @sceance_observable.id %>').removeClass('noted-ignored');

$('#sceance_observable_<%= @sceance_observable.id %>').addClass('noted-<%= sceance_customer_observable_note_label(@sceance_observable) %>')
