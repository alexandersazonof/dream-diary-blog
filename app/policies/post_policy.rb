class PostPolicy < ApplicationPolicy

  def index?
    true
  end

  def edit?
    user.present? && (user.id == article.user_id || user.is_admin?)
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (user.id == article.user_id || user.is_admin?)
  end

  def destroy?
    user.present? && (user.id == article.user_id || user.is_admin?)
  end

  private
    def article
      post
    end

end
