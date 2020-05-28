FactoryBot.define do
  factory :apply_vacancy do
    profile 
    vacancy
    apply_message { 'Tenho 5 anos de experiência em Ruby on Rails' }
  end
end
