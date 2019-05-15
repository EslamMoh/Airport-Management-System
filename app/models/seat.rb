class Seat < ApplicationRecord
  # finite state machine config
  include AASM

  aasm column: 'status' do
    state :available, initial: true
    state :booked
    state :pending

    event :book do
      transitions from: :available, to: :pending
    end

    event :confirm do
      transitions from: :pending, to: :booked
      error
    end
  end

  # Model associations
  belongs_to :ticket, optional: true
  belongs_to :flight_execution
  belongs_to :airplane

  # validations
  validates :number, uniqueness: { scope: :flight_execution_id }, presence: true
end
