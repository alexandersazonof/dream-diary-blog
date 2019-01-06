class Comment < ApplicationRecord
  belongs_to :post, required: false
  belongs_to :user, required: false
end
