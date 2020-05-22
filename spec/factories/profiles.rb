FactoryBot.define do
  factory :profile do
    full_name { "MyString" }
    social_name { "MyString" }
    birth_date { "2020-05-22" }
    formation { "MyString" }
    description { "MyString" }
    experience { "MyString" }
    photo { "" }
    candidate { nil }
  end
end
