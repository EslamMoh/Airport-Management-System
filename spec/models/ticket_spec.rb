require 'rails_helper'

RSpec.describe Ticket, type: :model do
  # Association test
  it { should belong_to(:passenger) }
  it { should belong_to(:flight) }
  it { should have_many(:seats) }

  # Validation test
  it 'should validate that flight is available' do
    subject.flight = FactoryBot.build(:flight)
    subject.flight.sold!
    subject.valid? # run validations
    expect(subject.errors[:base]).to include('Sorry, this flight is sold')
    subject.flight = FactoryBot.build(:flight)
    subject.valid? # run validations
    expect(subject.errors[:base]).to_not include('Sorry, this flight is sold')
  end

  # callbacks
  it { is_expected.to callback(:pay_ticket).after(:create) }
  it { is_expected.to callback(:book_seats).after(:create) }
  it { is_expected.to callback(:update_flight_capacity).after(:create) }
end
