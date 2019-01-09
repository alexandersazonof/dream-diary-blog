class UserPolicy < ApplicationPolicy

  

  def destroy?
    user.is_admin?
  end

end
