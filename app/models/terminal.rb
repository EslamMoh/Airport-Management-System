class Terminal < ApplicationRecord
  # Model associations
  belongs_to :airport
  has_many :destination_flight_executions,
           class_name: 'FlightExecution',
           foreign_key: 'destination_terminal_id'
  has_many :departure_flight_executions,
           class_name: 'FlightExecution',
           foreign_key: 'departure_terminal_id'

  # validations
  validates :name, presence: true
  validates :name, uniqueness: { scope: :airport_id }
end
