class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 240 }
end
