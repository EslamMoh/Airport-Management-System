require 'rails_helper'

RSpec.describe Flight, type: :model do
  # Association test
  it { should belong_to(:departure_airport).class_name('Airport') }
  it { should belong_to(:destination_airport).class_name('Airport') }
  it { should belong_to(:user) }
  it { should have_many(:tickets) }
  it { should have_many(:flight_flight_executions).dependent(:destroy) }
  it { should have_many(:flight_executions).through(:flight_flight_executions) }

  # Validation test
  %i[departure_time arrival_time tickets_count destination_country 
     departure_country status direction_type flight_type name price]
    .each do |field|
    it { should validate_presence_of(field) }
  end
end
