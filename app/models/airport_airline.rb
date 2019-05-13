class AirportAirline < ApplicationRecord
  # Model associations
  belongs_to :airline
  belongs_to :airport

  # validations
  validates :airline_id, uniqueness: { scope: :airport_id }
end
