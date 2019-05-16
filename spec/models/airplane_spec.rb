require 'rails_helper'

RSpec.describe Airplane, type: :model do
  # Association test
  it { should belong_to(:airline) }
  it { should have_many(:flight_executions) }
  it { should have_many(:seats) }

  # Validation test
  it { should validate_presence_of(:manufacturer) }
  it { should validate_presence_of(:model_number) }
  it { should validate_presence_of(:capacity) }
  it { should validate_uniqueness_of(:model_number) }
end
