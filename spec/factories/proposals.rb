FactoryBot.define do
  factory :proposal do
    start_date { 10.days.from_now }
    salary { 2400 }
    benefits { 'VA, VR, vale-transporte' }
    job_functions { 'Desenvolver o back-end do projeto Rental Cars com Rails' }
    headhunter
    apply_vacancy
  end
end
