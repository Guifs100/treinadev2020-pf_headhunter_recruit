FactoryBot.define do
  factory :reject_apply_vacancy do
    feedback { "MyString" }
    headhunter { nil }
    apply_vacancy { nil }
  end
end
