json.data do
  json.type 'developer'
  json.id @developer.id
  json.created_at @developer.created_at
  json.updated_at @developer.updated_at

  json.attributes do
    json.username @developer.username
    json.email @developer.email
  end

  json.applications @developer.applications do |application|
    json.type 'application'
    json.id application.id
    json.created_at application.created_at
    json.updated_at application.updated_at

    json.attributes do
      json.name application.name
      json.key application.key
      json.description application.description
    end

    json.link api_v1_application_url(application.id)
  end
end