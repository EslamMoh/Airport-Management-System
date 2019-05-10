class Airplane < ApplicationRecord
  belongs_to :airline
  has_many :destination_flights, class_name: 'Flight', foreign_key: 'destination_airport_id'
  has_many :departure_flights, class_name: 'Flight', foreign_key: 'departure_airport_id'
end
