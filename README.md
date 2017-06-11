# Pls README

## Instructions for running
* Install repo `$ git clone git@github.com:chhhris/developer-portal.git`
* Load dependencies `$ bundle install` (assuming you have Bundler installed!)
* Create database `$ rails db:create` (yes Rails 5 `s/rack/rails` syntax works!)
* Update database `$ rails db:migrate`
* Run server `$ rails s`

## Usage (API Documentation)
* List of all applications `/applications`
* List of developers (admin only) `/developers`
* Find a developer `/developers/:username` (returns developer resource + list of developer's applications by :key)

## Specs
* Run spec suite `$ rspec spec`

## Application details
* Rails 5
* PostgreSQL
* No views (for now)
