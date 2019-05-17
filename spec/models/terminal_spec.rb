require 'rails_helper'

RSpec.describe Terminal, type: :model do
  # Association test
  it { should belong_to(:airport) }
  it do
    should have_many(:destination_flight_executions)
      .class_name('FlightExecution')
      .with_foreign_key(
        'destination_terminal_id'
      )
  end
  it do
    should have_many(:departure_flight_executions)
      .class_name('FlightExecution')
      .with_foreign_key(
        'departure_terminal_id'
      )
  end

  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:airport_id) }
end
