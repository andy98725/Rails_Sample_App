# Basic regex for email format
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z]+\z/i

class User < ApplicationRecord
  before_save {
    self.email.downcase!
  }
  validates :name, presence: true, length: {maximum: 50}
  validates :uName, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 50}
  validates :email, presence: true, uniqueness: true, length: {maximum: 200},
                    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 6, maximum: 70}
  has_secure_password
end
