class FlightFlightExecution < ApplicationRecord
  # Model associations
  belongs_to :flight
  belongs_to :flight_execution

  # validations
  validates :flight_id, uniqueness: { scope: :flight_execution_id }
end
