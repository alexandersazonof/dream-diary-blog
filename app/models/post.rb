class Post < ApplicationRecord

  validates :content, presence: true
  validates :user_id, presence: true

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags

  default_scope -> { order('created_at DESC') }

  belongs_to :user
end
