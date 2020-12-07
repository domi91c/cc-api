FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    confirmed_at { Date.today }
  end
end
