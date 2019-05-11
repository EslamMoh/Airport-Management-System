class Seat < ApplicationRecord
  # Model associations
  belongs_to :ticket
  belongs_to :flight_execution
end
