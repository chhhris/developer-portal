json.data do
  json.type 'application'
  json.id @application.id
  json.created_at @application.created_at
  json.updated_at @application.updated_at

  json.attributes do
    json.name @application.name
    json.key @application.key
    json.description @application.description
  end

  json.author do
    json.type 'developer'
    json.id @application.developer.id
    json.created_at @application.developer.created_at
    json.updated_at @application.developer.updated_at

    json.attributes do
      json.username @application.developer.username
      json.email @application.developer.email
    end

    json.link api_v1_developer_url(@application.developer.id)
  end

  json.link api_v1_application_url(@application.id)
end