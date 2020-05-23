FactoryBot.define do
  factory :candidate do
    sequence(:email) { |n| "email#{n}@candidates.com.br" }
    password {'12345678'}
    # profile { nil }
  end
end
