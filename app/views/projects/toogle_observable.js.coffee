$('#project_observable_<%= @project_observable.id %>').<%= @project_observable.ignored? ? 'add' : 'remove' %>Class('ignored');
