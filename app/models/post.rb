class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  before_validation :generate_url_token

  validates :image, presence: true
  validates :caption, length: { maximum: 240 }
  validates :user_id, presence: true
  validates :url_token, presence: true, uniqueness: true

  def to_param
    url_token
  end

  private

    def generate_url_token
      self.url_token = SecureRandom.urlsafe_base64
    end
end
