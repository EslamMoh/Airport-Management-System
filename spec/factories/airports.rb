FactoryBot.define do
  factory :airport do
    user
    name { Faker::Company.name }
    city { Faker::Address.city }
    country { Faker::Address.country }
  end
end
