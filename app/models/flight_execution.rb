class FlightExecution < ApplicationRecord
  # Model associations
  belongs_to :airplane
  belongs_to :departure_terminal, class_name: 'Terminal'
  belongs_to :destination_terminal, class_name: 'Terminal'
  belongs_to :user
  has_many :seats
  has_many :flight_flight_executions, dependent: :destroy
  has_many :flights, through: :flight_flight_executions
end
