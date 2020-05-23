FactoryBot.define do
  factory :vacancy do
    title { "Desenvolvedor Junior" }
    job_description { "Trabalhar em equipe, proatividade, compromisso e disciplina" }
    skills { "Ruby, Rails, Banco de Dados" }
    salary { 1200 }
    level
    registration_date { 10.days.from_now }
    address { "Av. Paulista, 1234 SP" }
  end
end
