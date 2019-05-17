class Airport < ApplicationRecord
  # Model associations
  belongs_to :user
  has_many :terminals
  has_many :destination_flights, class_name: 'Flight',
                                 foreign_key: 'destination_airport_id'
  has_many :departure_flights, class_name: 'Flight',
                               foreign_key: 'departure_airport_id'
  has_many :airport_airlines, dependent: :destroy
  has_many :airlines, through: :airport_airlines

  # validations
  validates :name, :country, :city, presence: true
  validates :name, :city, uniqueness: { scope: :user_id }
end
