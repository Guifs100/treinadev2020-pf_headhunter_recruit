FactoryBot.define do
  factory :profile do
    full_name { "Fulano Silva" }
    social_name { "Fulano" }
    birth_date { "15/11/1996" }
    formation { "Análise e desenvolvimento de sistemas" }
    description { "Formado na Fatec" }
    experience { "Nenhuma" }
    # photo { 'assets/images/perfil.jpg' }
    candidate
    # after(:build) do |profile|
      # profile.photo.attach(io: File.open(Rails.root.join('spec','support', 'assets', 'perfil.jpg' )), filename: 'perfil.jpg', content_type: 'image/jpeg' )
    # end
  end
end
