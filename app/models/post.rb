class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  before_validation :generate_url_token, on: :create

  validates :image, presence: true
  validates :caption, length: { maximum: 240 }
  validates :user_id, presence: true
  validates :url_token, presence: true, uniqueness: { case_sensitive: true }

  def to_param
    url_token
  end

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def like?(user)
    like_users.include?(user)
  end

  private

  def generate_url_token
    self.url_token = SecureRandom.urlsafe_base64
  end
end
