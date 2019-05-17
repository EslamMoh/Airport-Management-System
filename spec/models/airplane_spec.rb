require 'rails_helper'

RSpec.describe Airplane, type: :model do
  # Association test
  it { should belong_to(:airline) }
  it { should have_many(:flight_executions) }
  it { should have_many(:seats) }

  # Validation test
  %i[manufacturer model_number capacity].each do |field|
    it { should validate_presence_of(field) }
  end
  it { should validate_uniqueness_of(:model_number) }
end
