class FlightFlightExecution < ApplicationRecord
  belongs_to :flight
  belongs_to :flight_execution
end
