FactoryBot.define do
  factory :terminal do
    airport
    name { Faker::Number.number(2) }
  end
end
