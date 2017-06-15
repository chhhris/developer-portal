class Api::V1::BaseController < ActionController::API
  attr_accessor :current_user

  include Pundit

  # before_action :authenticate_developer!

  def authenticate_developer!
    current_user = Developer.find(ApiAuth.access_id(request))

    unless current_user && ApiAuth.authentic?(request, current_user.authentication_token)
      head(:unauthorized)
    end
  end
end
