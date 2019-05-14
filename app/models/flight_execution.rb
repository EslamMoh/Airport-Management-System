class FlightExecution < ApplicationRecord
  # Model associations
  belongs_to :airplane
  belongs_to :departure_terminal, class_name: 'Terminal'
  belongs_to :destination_terminal, class_name: 'Terminal'
  belongs_to :user
  has_many :seats
  has_many :flight_flight_executions, dependent: :destroy
  has_many :flights, through: :flight_flight_executions

  # validations
  validates :departure_time, :arrival_time, presence: true

  # callbacks
  after_create :generate_seats

  protected

  def generate_seats
    seats_numbers = Array.new(airplane.capacity) { |i| i + 1 }
    seats_numbers.map do |seat_number|
      seats.create!(number: seat_number, airplane_id: airplane.id)
    end
  end
end
