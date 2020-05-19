# Basic regex for email format
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z]+\z/i

class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {
    self.email.downcase!
  }
  validates :name, presence: true, length: {maximum: 50}
  validates :uName, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates :email, presence: true, uniqueness: true, length: {maximum: 200},
                    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 6, maximum: 70}
  has_secure_password

  # Get the hash digest of a string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Generate a random token
  def User.newtoken
    SecureRandom.urlsafe_base64
  end

  # Generate a remember token
  def remember
    self.remember_token = User.newtoken
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Check if is authenticated with token
  def authenticated?(token)
    return false if (!remember_digest)
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  # Forget the remember token
  def forget
    self.remember_token = nil
    update_attribute(:remember_digest, nil)
  end
end
