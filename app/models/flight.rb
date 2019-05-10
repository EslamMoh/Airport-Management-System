class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :destination_airport, class_name: 'Airport'
  has_many :flight_executions
  has_many :tickets
end
