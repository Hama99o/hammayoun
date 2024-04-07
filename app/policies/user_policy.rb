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
    # user.admin_or_above? || user== record
    true
  end

  def create?
    # user.admin_or_above?
    true
  end

  def update?
    # show?
    true
  end

  def destroy?
    # create?
    true
  end

  def reset_password?
    true
  end
end
