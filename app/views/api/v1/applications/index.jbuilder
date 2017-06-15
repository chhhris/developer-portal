json.data @applications do |application|
  json.type 'application'
  json.id application.id
  json.created_at application.created_at
  json.updated_at application.updated_at

  json.attributes do
    json.name application.name
    json.key application.key
    json.description application.description
  end

  json.developer do
    json.id application.developer.id
    json.username application.developer.username
  end

  json.link api_v1_application_url(application.id)
end