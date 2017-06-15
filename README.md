# Pls README

## Running the _Developer Portal_ application

### Installation / Instructions
* Install repo `$ git clone git@github.com:chhhris/developer-portal.git`
* Load dependencies `$ bundle install` (requires [Bundler](http://bundler.io/) installed!)
* Create database `$ rails db:create` (yes Rails 5 `s/rack/rails` syntax works!)
* Update database `$ rails db:migrate` if necessary
* Run server `$ rails s`

### Test suite
* `$ rake db:test:prepare`
* Run spec suite `$ rspec spec`

### Application details
* Rails 5
* PostgreSQL
* REST-ful / HTML-less (no client (frontend); using [Jbuilder templates](https://github.com/rails/jbuilder) to format `json` responses)
* Rate limiting via [Rack::Attack gem](https://github.com/kickstarter/rack-attack) from Kickstarter

### Known issues / Design considerations / To Do's
* Implement SSL for production and development. In development this would require generating a self signed SSL cert (key, csr and certificate), updating configs to force SSL in prod and dev files, and finally if you are using OS X you would add the cert to Keychain Access.
* Enable CORS (cross origin HTTP requests) if frontend client and backend are hosted on different domains.
* Paginate API response data.
* Add ApplicationsController specs (I ran out of time; DevelopersController specs are representative).
* Add specs to test Authorization with Pundit (that only relevant Developer can edit their own applications)
* Add specs to test Rate Limiting. Sample spec e.g.
```
describe "throttle excessive requests by IP address" do
  let(:limit) { 20 }

  context "number of requests is lower than the limit" do
    it "does not change the request status" do
      limit.times do
        get "/", {}, "REMOTE_ADDR" => "1.2.3.4"
        expect(last_response.status).to_not eq(429)
      end
    end
  end

  ...
end
```

## _Developer Portal_ API Documentation

For new clients
1. Create a developer account `POST /api/v1/developers` (requires `username`, `email` and `password`)
2. Use email and password to retrieve API Key
3. Use developer id and api_key to authenticate API requests

Example signed GET request using RestClient.
```
  access_id = <your developer :id>
  access_key = <your API key>
  request = RestClient::Request.new(url: "/api/v1/developers/:id", headers: {}, method: :get)
  signed_request = ApiAuth.sign!(request, access_id, access_key)
  signed_request.execute
```

### Endpoints
```
GET     /api/v1/developers         developers#index
POST    /api/v1/developers         developers#create
GET     /api/v1/developers/:id     developers#show
PATCH   /api/v1/developers/:id     developers#update
PUT     /api/v1/developers/:id     developers#update
DELETE  /api/v1/developers/:id     developers#destroy
GET     /api/v1/applications       applications#index
POST    /api/v1/applications       applications#create
GET     /api/v1/applications/:id   applications#show
PATCH   /api/v1/applications/:id   applications#update
PUT     /api/v1/applications/:id   applications#update
DELETE  /api/v1/applications/:id   applications#destroy
```

### Response formats
* Roughly follows the [jsonapi.org](http://jsonapi.org/format/) specification for server response formats.

#### **GET** `/developers`
```
{
  "data": [
    {
      "type": "developer",
      "id": 2,
      "created_at": "2017-06-11T05:01:01.786Z",
      "updated_at": "2017-06-11T05:01:01.786Z",
      "attributes": {
        "username": "silverback_gorilla",
        "email" "not.a.monkey@gmail.com"
      },
      "applications": {
        "count": 3,
        "ids": [2342, 123233, 897822]
      },
      "link": "http://localhost:3000/api/v1/developers/2"
    },
    ...
  ]
}
```

#### **GET** `/developers/:user_id`
```
{
  "data": {
    "type": "developer",
    "id": 2,
    "created_at": "2017-06-11T05:01:01.786Z",
    "updated_at": "2017-06-11T05:01:01.786Z",
    "attributes": {
      "username": "silverback_gorilla",
      "email" "not.a.monkey@gmail.com"
    },
    "applications": [
      {
        "type": "application",
        "id": 5,
        "created_at": "2017-06-11T05:04:06.654Z",
        "updated_at": "2017-06-11T05:04:06.654Z",
        "attributes": {
          "name": "A Silverback's Life",
          "key": "a_silverbacks_life",
          "description": "An inside look at life as the most badass ape in the ape kingdom."
        },
        "link": "http://localhost:3000/api/v1/applications/5"
      },
      "link": "http://localhost:3000/api/v1/developers/2"
      ...
    ]
  }
}
