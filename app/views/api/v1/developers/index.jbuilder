json.data @developers do |developer|
  json.type 'developer'
  json.id developer.id
  json.created_at developer.created_at
  json.updated_at developer.updated_at

  json.attributes do
    json.username developer.username
    json.email developer.email
  end

  json.applications do
    json.count developer.applications.count
    json.ids developer.applications.pluck(:id)
  end

  json.link api_v1_developer_url(developer.id)
end