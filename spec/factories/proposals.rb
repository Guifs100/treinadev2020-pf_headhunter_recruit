FactoryBot.define do
  factory :proposal do
    start_date { "2020-05-29" }
    salary { "9.99" }
    benefits { "MyString" }
    job_functions { "MyString" }
    headhunter { nil }
    apply_vacancy { nil }
  end
end
