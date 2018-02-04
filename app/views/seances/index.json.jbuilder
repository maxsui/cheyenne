json.array! @seances do |seance|
  json.(seance, :id)
  json.title (seance.customers + seance.groups).map(&:name).join(' - ')
  json.allDay false

  json.start seance.begin
  json.end seance.end

  json.url seance_path(seance)
  json.editable false
end
