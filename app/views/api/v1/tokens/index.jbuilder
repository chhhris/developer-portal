json.data do
  json.type 'developer'
  json.id @developer.id
  json.access_key @developer.authentication_token
  json.created_at @developer.created_at
  json.updated_at @developer.updated_at
end