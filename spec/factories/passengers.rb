FactoryBot.define do
  factory :passenger do
    name { Faker::Name.name }
    password { Faker::Internet.password(20, 20) }
    phone { '20114' + Kernel.rand(10**7).to_s.rjust(7, '0') }
    email { Faker::Internet.email }
  end
end
