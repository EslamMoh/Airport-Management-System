require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_secure_password }
  it { should have_many(:airports) }
  it { should have_many(:flights) }
  it { should have_many(:flight_executions) }

  # Validation test
  %i[name email password_digest phone].each do |field|
    it { should validate_presence_of(field) }
  end
  it { should validate_uniqueness_of(:email) }
  it 'should validate that phone is available' do
    subject.phone = '01000510'
    subject.valid? # run validations
    expect(subject.errors[:phone]).to include('is invalid')
    subject.phone = '201111628811'
    subject.valid? # run validations
    expect(subject.errors[:phone]).to_not include('is invalid')
  end
  it 'should validate that email is available' do
    subject.email = 'test.com'
    subject.valid? # run validations
    expect(subject.errors[:email]).to include('only allows valid emails')
    subject.email = 'test@gmail.com'
    subject.valid? # run validations
    expect(subject.errors[:phone]).to_not include('only allows valid emails')
  end
end
