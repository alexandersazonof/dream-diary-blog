class UserPolicy < ApplicationPolicy

  def edit?
    current_user.is_admin?
  end

  def update?
    current_user.is_admin?
  end

  def destroy?
    current_user.is_admin?
  end

end
