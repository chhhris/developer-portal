# Pls README

## Running the _Developer Portal_ application

### Installation / Instructions
* Install repo `$ git clone git@github.com:chhhris/developer-portal.git`
* Load dependencies `$ bundle install` (requires [Bundler](http://bundler.io/) installed!)
* Create database `$ rails db:create` (yes Rails 5 `s/rack/rails` syntax works!)
* Update database `$ rails db:migrate` if necessary
* Run server `$ rails s`

### Running test suite
* Ensure test db is setup `$ rake db:test:prepare`
* Run rspec `$ rspec spec`

### Application details
* Rails 5
* PostgreSQL
* RESTful
* JSON formatted via [Jbuilder templates](https://github.com/rails/jbuilder)
* Authentication via [API Auth](https://github.com/mgomes/api_auth)
* Authorization via [Pundit](https://github.com/elabs/pundit)
* Rate limiting via [Rack::Attack](https://github.com/kickstarter/rack-attack) (Kickstarter)

### Known issues / Design considerations / To Do's
* Implement SSL for production and development. In development this would require generating a self signed SSL cert (key, csr and certificate), updating configs to force SSL in prod and dev files, add the cert to Keychain Access (OS X).
* Enable CORS (cross origin HTTP requests) if frontend client and backend are hosted on different domains.
* Refactor / rethink how API key / auth token is requested and returned to user.
* Paginate API response data.
* Add ApplicationsController specs (I ran out of time; DevelopersController specs are representative).
* Add specs to test Authorization with Pundit (that only the Application's Developer can edit their own applications)
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
1. Create a developer account `POST /api/v1/developers` (required fields: `username`, `email` and `password`)
2. Use email and password to retrieve API Key `GET /api/v1/tokens` supplying `email` and `password` as request parameters. This returns Developer object with :id and :api_key
3. Use developer :id and :api_key to HMAC encrypt / authenticate API requests

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

#### **GET** `/developers/:id`
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
      ...
    ],
    "link": "http://localhost:3000/api/v1/developers/2"
  }
}
```

## Questions? Concerns? Feedback?
Would love to [hear from you](https://twitter.com/chhhris)!
