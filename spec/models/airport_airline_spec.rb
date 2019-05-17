require 'rails_helper'

RSpec.describe AirportAirline, type: :model do
  # Association test
  it { should belong_to(:airline) }
  it { should belong_to(:airport) }

  # Validation test
  it do
    subject.airline = FactoryBot.build(:airline)
    should validate_uniqueness_of(:airline_id).scoped_to(:airport_id)
  end
end
