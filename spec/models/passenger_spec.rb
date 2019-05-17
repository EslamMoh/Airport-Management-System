require 'rails_helper'

RSpec.describe Passenger, type: :model do
  # Association test
  it { should have_secure_password }
  it { should have_many(:tickets) }

  # Validation test
  %i[name email password_digest phone].each do |field|
    it { should validate_presence_of(field) }
  end
  it { should validate_uniqueness_of(:email) }
end
