class Airline < ApplicationRecord
  has_many :airplanes
  has_many :airport_airlines, dependent: :destroy
  has_many :airports, through: :airport_airlines
end
