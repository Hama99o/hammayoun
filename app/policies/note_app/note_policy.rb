class NoteApp::NotePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin_or_above?
        scope.all
      else
        scope.where(owner: user)
      end
    end
  end

  def show?
    user == record.owner
  end

  def create?
    # user.admin_or_above?
    true
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

end
