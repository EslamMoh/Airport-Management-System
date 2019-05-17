require 'rails_helper'

RSpec.describe FlightExecution, type: :model do
  # Association test
  it { should belong_to(:airplane) }
  it do
    should belong_to(:departure_terminal).class_name('Terminal')
  end
  it do
    should belong_to(:destination_terminal).class_name('Terminal')
  end
  it { should belong_to(:user) }
  it { should have_many(:seats) }
  it { should have_many(:flight_flight_executions).dependent(:destroy) }
  it { should have_many(:flights).through(:flight_flight_executions) }

  # Validation test
  %i[departure_time arrival_time].each do |field|
    it { should validate_presence_of(field) }
  end

  # callbacks
  it { is_expected.to callback(:generate_seats).after(:create) }
end
