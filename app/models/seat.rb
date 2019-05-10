class Seat < ApplicationRecord
  belongs_to :ticket
  belongs_to :flight_execution
end
