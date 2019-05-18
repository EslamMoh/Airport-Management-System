class Airline < ApplicationRecord
  # Model associations
  has_many :airplanes
  has_many :airport_airlines, dependent: :destroy
  has_many :airports, through: :airport_airlines

  # validations
  validates :name, :origin_country, presence: true
  validates :name, uniqueness: true
end
