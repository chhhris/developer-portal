require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module DeveloperPortal
  class Application < Rails::Application
    config.load_defaults 5.1
    config.api_only = true
    # route 404s and 500s to ErrorsController
    config.exceptions_app = self.routes
    # rate limiting
    config.middleware.use Rack::Attack
    config.active_record.default_timezone = :utc
  end
end
