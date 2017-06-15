class ApplicationPolicy < BasePolicy
  attr_reader :user, :application

  def initialize(user, application)
    @user = user
    @application = application
  end

  def update?
    user.id == application.developer.id && user.authentication_token == application.developer.authentication_token
  end

  def destroy?
    update?
  end

end
