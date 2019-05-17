FactoryBot.define do
  factory :flight_execution do
    user
    airplane
    departure_terminal { create :terminal }
    destination_terminal { create :terminal }
    departure_time { rand(10).day.from_now }
    arrival_time { rand(10).day.from_now }
  end
end
