require 'rails_helper'

RSpec.describe FlightFlightExecution, type: :model do
  # Association test
  it { should belong_to(:flight) }
  it { should belong_to(:flight_execution) }

  # Validation test
  it do
    subject.flight = FactoryBot.build(:flight)
    should validate_uniqueness_of(:flight_id).scoped_to(:flight_execution_id)
  end
end
