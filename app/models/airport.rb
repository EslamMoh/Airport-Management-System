class Airport < ApplicationRecord
  belongs_to :user
  has_many :terminals
  has_many :destination_flights, class_name: 'Flight', foreign_key: 'destination_airport_id'
  has_many :departure_flights, class_name: 'Flight', foreign_key: 'departure_airport_id'
end
