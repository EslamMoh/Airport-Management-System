FactoryBot.define do
  factory :airline do
    name { Faker::Company.name }
    origin_country { 'Egypt' }
  end
end
