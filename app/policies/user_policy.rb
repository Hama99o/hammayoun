class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin_or_above?
        scope.all
      else
        # Handle unauthorized access
        raise Pundit::NotAuthorizedError, "not allowed to perform this action"
      end

      scope.all #TODO
    end
  end

  def show?
    user.admin_or_above? || user == record
  end

  def create?
    # user.admin_or_above?
  end

  def update?
    show?
  end

  def destroy?
    create?
  end

  def reset_password?
    true
  end
end
