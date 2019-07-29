class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :image, presence: true
  validates :caption, length: { maximum: 240 }
  validates :user_id, presence: true

end
