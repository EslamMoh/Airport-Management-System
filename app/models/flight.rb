class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :destination_airport, class_name: 'Airport'
  has_many :tickets
  has_many :flight_flight_executions, dependent: :destroy
  has_many :flight_executions, through: :flight_flight_executions
end
