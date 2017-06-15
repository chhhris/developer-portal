# Pls README

## Running the _Developer Portal_ application

### Installation / Instructions
* Install repo `$ git clone git@github.com:chhhris/developer-portal.git`
* Load dependencies `$ bundle install` (assuming you have Bundler installed!)
* Create database `$ rails db:create` (yes Rails 5 `s/rack/rails` syntax works!)
* Update database `$ rails db:migrate`
* Run server `$ rails s`

### Test suite
* '$ rake db:test:prepare'
* Run spec suite `$ rspec spec`

### Application details
* Rails 5
* PostgreSQL
* REST-ful / HTML-less (no client (frontend); using [Jbuilder templates](https://github.com/rails/jbuilder) to format `json` responses)
* Rate limiting via [Rack::Attack gem](https://github.com/kickstarter/rack-attack) from Kickstarter

## TODO
* Authentication (https://labs.kollegorna.se/blog/2015/04/build-an-api-now/ with https://github.com/mgomes/api_auth gem)
* Authorization with pundit (that only relevant Developer can edit their own applications)
* How to test Rack::Attack  ??


### Known issues / Design considerations
* Use SSL for production and development.
* CORS
* Pagination

## _Developer Portal_ API Documentation
* Roughly following the [jsonapi.org](http://jsonapi.org/format/) specification for server response formats.

**GET** `/developers`
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

**GET** `/developers/:user_id`
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
```

* List of all applications `/applications`
* List of developers (admin only) `/developers`
* Find a developer `/developers/:username` (returns developer resource + list of developer's applications by :key)
