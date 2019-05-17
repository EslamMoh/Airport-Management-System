FactoryBot.define do
  factory :flight do
    user
    name { Faker::Number.number(3) }
    price { 500 }
    flight_type { 'stop' }
    direction_type { 'one_way' }
    departure_country { Faker::Address.country }
    destination_country { Faker::Address.country }
    departure_airport { create :airport, user: user }
    destination_airport { create :airport, user: user }
    departure_time { rand(10).day.from_now }
    arrival_time { rand(10).day.from_now }
    tickets_count { 200 }
  end
end
