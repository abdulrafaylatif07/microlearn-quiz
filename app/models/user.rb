class User < ApplicationRecord
  has_secure_password
  has_many :quizzes
  validates :email, presence: true, uniqueness: true
end