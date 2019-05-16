class Ticket < ApplicationRecord
  # finite state machine config
  include AASM

  aasm column: 'payment_status' do
    state :not_paid, initial: true
    state :paid

    event :pay do
      transitions from: :not_paid, to: :paid
    end
  end

  # Model associations
  belongs_to :passenger
  belongs_to :flight
  has_many :seats

  # validations
  validate :check_flight_availability

  # callbacks
  after_create :pay_ticket
  after_create :book_seats
  after_create :update_flight_capacity

  def confirm!
    seats.each(&:confirm!)
  end

  private

  def check_flight_availability
    errors.add(:base, 'Sorry, this flight is sold') unless flight.available?
  end

  def pay_ticket
    pay!
  end

  def book_seats
    flight.flight_executions.each do |flight_execution|
      seats << flight_execution.seats.available.first
    end

    seats.each(&:book!)
  end

  def update_flight_capacity
    flight_capacity = flight.tickets_count - 1
    flight.update!(tickets_count: flight_capacity)

    flight.sold! if flight_capacity.zero?
  end
end
