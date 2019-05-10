class Ticket < ApplicationRecord
  belongs_to :passenger
  belongs_to :flight
  has_many :seats
end
