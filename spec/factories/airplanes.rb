FactoryBot.define do
  factory :airplane do
    airline
    manufacturer { Faker::Company.name }
    model_number { Faker::Number.number(10) }
    capacity { Faker::Number.number(3) }
  end
end
