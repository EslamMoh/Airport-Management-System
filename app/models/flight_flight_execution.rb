class FlightFlightExecution < ApplicationRecord
  # Model associations
  belongs_to :flight
  belongs_to :flight_execution
end
