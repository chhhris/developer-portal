class BasePolicy
  attr_reader :developer, :record

  def initialize(developer, record)
    @developer = developer
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    true
  end

  def new?
    create?
  end

  def scope
    Pundit.policy_scope!(developer, record.class)
  end

  class Scope
    attr_reader :developer, :scope

    def initialize(developer, scope)
      @developer = developer
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
