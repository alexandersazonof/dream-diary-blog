class AddCommentableToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :commentble, polymorphic: true
  end
end
