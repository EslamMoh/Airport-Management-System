require 'rails_helper'

RSpec.describe Airport, type: :model do
  # Association test
  it { should belong_to(:user) }
  it { should have_many(:terminals) }
  it do
    should have_many(:destination_flights).class_name('Flight')
                                          .with_foreign_key(
                                            'destination_airport_id'
                                          )
  end
  it do
    should have_many(:departure_flights).class_name('Flight')
                                        .with_foreign_key(
                                          'departure_airport_id'
                                        )
  end
  it { should have_many(:airport_airlines).dependent(:destroy) }
  it { should have_many(:airlines).through(:airport_airlines) }

  # Validation test
  %i[name country city].each do |field|
    it { should validate_presence_of(field) }
  end
  %i[name city].each do |field|
    it { should validate_uniqueness_of(field).scoped_to(:user_id) }
  end
end
