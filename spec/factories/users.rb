FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password { Faker::Internet.password(20, 20, true, true) }
    phone { '20114' + Kernel.rand(10**7).to_s.rjust(7, '0') }
    email { Faker::Internet.email }
  end
end
