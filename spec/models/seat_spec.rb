require 'rails_helper'

RSpec.describe Seat, type: :model do
  # Association test
  it { is_expected.to belong_to(:ticket) }
  it { should belong_to(:flight_execution) }
  it { should belong_to(:airplane) }

  # Validation test
  it { should validate_presence_of(:number) }
  it { should validate_uniqueness_of(:number).scoped_to(:flight_execution_id) }
end
