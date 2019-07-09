class User < ApplicationRecord
  
  validates :name, presence: true, length: { maximum: 20 }
  validates :username, namespace: true, presence: true, uniqueness: { case_sensitive: :false }, length: { minimum: 4, maximum: 20 },
                       format: { with: /\A[a-z0-9_]+\z/ }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
            :rememberable, :validatable, :confirmable, authentication_keys: [:login]
  attr_writer :login

  def to_param
    username
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end