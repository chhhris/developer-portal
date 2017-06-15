class DeveloperPolicy < BasePolicy
  attr_reader :user, :developer

  def initialize(user, developer)
    @user = user
    @developer = developer
  end

  def show?
    update?
  end

  def update?
    user.id == developer.id && user.authentication_token == developer.authentication_token
  end

  def destroy?
    update?
  end

end
