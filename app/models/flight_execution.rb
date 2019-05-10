class FlightExecution < ApplicationRecord
  belongs_to :flight
  belongs_to :airplane
  belongs_to :departure_terminal, class_name: 'Terminal'
  belongs_to :destination_terminal, class_name: 'Terminal'
end
