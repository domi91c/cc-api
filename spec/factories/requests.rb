FactoryBot.define do
  factory :request do
    status { "MyString" }
    guest { nil }
    stream { nil }
  end
end
