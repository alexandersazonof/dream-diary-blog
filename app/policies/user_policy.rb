class UserPolicy < ApplicationPolicy

  def edit?
    user.is_admin?
  end

  def update?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end

end
