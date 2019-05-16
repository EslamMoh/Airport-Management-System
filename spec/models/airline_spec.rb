require 'rails_helper'

RSpec.describe Airline, type: :model do
  # Association test
  it { should have_many(:airplanes) }
  it { should have_many(:airport_airlines).dependent(:destroy) }
  it { should have_many(:airports).through(:airport_airlines) }

  # Validation test
  it { should validate_uniqueness_of(:name) }
end
