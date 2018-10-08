class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.role == 'Admin'
  end

  def new?
    create?
  end

  def update?
    user.role == 'Admin'
  end

  def edit?
    update?
  end

  def delete?
    destroy?
  end

  def destroy?
    user.role == 'Admin'
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
