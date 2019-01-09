class CommentPolicy < ApplicationPolicy

def destroy?
  user.present? && (user.id == comment.user_id || user.is_admin?)
end

end
