FactoryBot.define do
  factory :profile do
    full_name { "Fulano Silva" }
    social_name { "Fulano" }
    birth_date { "15/11/1996" }
    formation { "Análise e desenvolvimento de sistemas" }
    description { "Formado na Fatec" }
    experience { "Nenhuma" }
    candidate
    trait :with_photo do
      photo {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg')}
    end
  end
end
