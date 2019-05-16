class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :airports
  has_many :flights
  has_many :flight_executions

  # Validations
  validates :name, :email, :password_digest, :phone, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'only allows valid emails' }
  validates :phone, phone: true # phonelib validation
end
