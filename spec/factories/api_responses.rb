FactoryBot.define do
  factory :api_response do
    response { "" }
    api { "MyString" }
    kind { "MyString" }
    owner { nil }
  end
end
