class PostPolicy < ApplicationPolicy



  def index?
    true
  end

  def edit?
    user.present? && user.id == article.user_id
  end

  def create?
    user.present?
  end

  def update?
    user.present? && user.id == article.user_id
  end

  def destroy?
    return true if user.present? && user.id == article.user_id
  end

  private
    def article
      post
    end

end
