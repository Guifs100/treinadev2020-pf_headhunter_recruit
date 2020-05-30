FactoryBot.define do
  factory :reject_apply_vacancy do
    feedback { "Não se enquadra a vaga" }
    headhunter
    apply_vacancy 
  end
end
