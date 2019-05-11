class AirportAirline < ApplicationRecord
  # Model associations
  belongs_to :airline
  belongs_to :airport
end
