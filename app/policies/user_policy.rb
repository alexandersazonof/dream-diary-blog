class UserPolicy < ApplicationPolicy

  def edit?
    user.present? && user.is_admin?
  end

  def update?
    user.present? && user.is_admin?
  end

  def destroy?
    user.present? && user.is_admin?
  end

end
