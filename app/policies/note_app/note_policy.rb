class NoteApp::NotePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    user == record.owner || record.shared_with_users.where(id: user.id).present?
  end

  def create?
    user.present?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def share_with_user_toggle?
    true
  end

  def restore?
    show?
  end

  def destroy_permanently?
    show?
  end
end
