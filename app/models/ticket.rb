class Ticket < ApplicationRecord
  # Model associations
  belongs_to :passenger
  belongs_to :flight
  has_many :seats
end
