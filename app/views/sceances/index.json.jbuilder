json.array! @sceances do |sceance|
  json.(sceance, :id)
  json.title sceance.customers.map(&:name).join(' - ')
  json.allDay false

  json.start sceance.begin
  json.end sceance.end

  json.url sceance_path(sceance)
  json.editable false
end
