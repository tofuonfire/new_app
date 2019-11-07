class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy

  has_many :active_relationships,  class_name: 'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :bio, length: { maximum: 140 }
  validates :username, namespace: true, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 },
                       format: { with: /\A[a-z0-9_]+\z/ }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, authentication_keys: [:login]
  attr_writer :login

  def to_param
    username
  end

  def login
    @login || username || email
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしているならtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # rubocop:disable Rails/FindBy, Lint/AssignmentInCondition
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
  # rubocop:enable Rails/FindBy, Lint/AssignmentInCondition
end
