FactoryBot.define do
  factory :headhunter do
    sequence(:email) { |n| "email#{n}@headhunter.com.br" }
    password {'12345678'}
  end
end
