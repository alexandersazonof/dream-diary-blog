class Post < ApplicationRecord

  validates :content, presence: true
  validates :user_id, presence: true

  default_scope -> { order('created_at DESC') }

  belongs_to :user
end
