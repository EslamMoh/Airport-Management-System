FactoryBot.define do
  factory :airline do
    name { Faker::Company.name }
    origin_country { Faker::Address.country }
  end
end
