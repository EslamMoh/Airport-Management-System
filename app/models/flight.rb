class Flight < ApplicationRecord
  # finite state machine config
  include AASM

  aasm column: 'status' do
    state :available, initial: true
    state :sold_out

    event :sold do
      transitions from: :available, to: :sold_out
    end
  end

  # Model associations
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :destination_airport, class_name: 'Airport'
  belongs_to :user
  has_many :tickets
  has_many :flight_flight_executions, dependent: :destroy
  has_many :flight_executions, through: :flight_flight_executions

  # validations
  validates :departure_time, :arrival_time, :capacity, :destination_country,
            :departure_country, :status, :direction_type, :flight_type, :name,
            :price, presence: true

  # enums
  enum flight_type: %i[stop non_stop]
  enum direction_type: %i[one_way round]
end
