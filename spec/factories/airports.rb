FactoryBot.define do
  factory :airport do
    user
    name { Faker::Company.name }
    city { 'Cairo' }
    country { 'Egypt' }
  end
end
