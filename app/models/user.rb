class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :airports
  has_many :flights
  has_many :flight_executions

  # Validations
  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
