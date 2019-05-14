class Passenger < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :tickets

  # Validations
  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
