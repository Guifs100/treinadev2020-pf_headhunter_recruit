require 'rails_helper'

feature 'Candidate accept proposal' do
  let(:profile) {create :profile, :with_photo}

  scenario 'successfully reject' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    candidate = create(:candidate, email: 'test@candidate.com',
                                    password: '12345678')
    profile.candidate = candidate
    candidate.profile = profile
    level = create(:level, name: 'Júnior')
    other_level = create(:level, name: 'Sênior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    other_vacancy = Vacancy.create!(title: "Programador Senior",
                                    job_description: "Proatividade e compromisso para desenvolver com a equipe",
                                    skills: "SQL, C, Java",
                                    salary: 2400,
                                    level: other_level,
                                    registration_date: 10.days.from_now,
                                    address: "Av. Paulista, 1234 SP",
                                    headhunter: headhunter,
                                    status: 0)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    other_apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: other_vacancy)
    proposal = create(:proposal, start_date: 10.days.from_now,
                                salary: 2400,
                                benefits: 'VA, VR, vale-transporte',
                                job_functions: 'Desenvolver o back-end do projeto Rental Cars com Rails',
                                headhunter: headhunter,
                                apply_vacancy: apply_vacancy)
    proposal.answer = 'Obrigado pela oportunidade, mas vou rejeitar'
    proposal.rejected!

    # TODO: Ver pq o answer fica nulo se ele ficar depois de rejected

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Respostas de Propostas'

    expect(page).to have_content('Respostas Recebidas')
    expect(page).to have_content(proposal.status)
    expect(page).to have_content(proposal.answer)
  end

  scenario 'successfully accepted' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    candidate = create(:candidate, email: 'test@candidate.com',
                                    password: '12345678')
    profile.candidate = candidate
    candidate.profile = profile
    level = create(:level, name: 'Júnior')
    other_level = create(:level, name: 'Sênior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    other_vacancy = Vacancy.create!(title: "Programador Senior",
                                    job_description: "Proatividade e compromisso para desenvolver com a equipe",
                                    skills: "SQL, C, Java",
                                    salary: 2400,
                                    level: other_level,
                                    registration_date: 10.days.from_now,
                                    address: "Av. Paulista, 1234 SP",
                                    headhunter: headhunter,
                                    status: 0)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    other_apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: other_vacancy)
    proposal = create(:proposal, start_date: 10.days.from_now,
                                salary: 2400,
                                benefits: 'VA, VR, vale-transporte',
                                job_functions: 'Desenvolver o back-end do projeto Rental Cars com Rails',
                                headhunter: headhunter,
                                apply_vacancy: apply_vacancy)
    proposal.answer = 'Obrigado pela oportunidade, mas vou rejeitar'
    proposal.accepted!

    # TODO: Ver pq o answer fica nulo se ele ficar depois de rejected

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Respostas de Propostas'

    expect(page).to have_content('Respostas Recebidas')
    expect(page).to have_content(proposal.status)
    expect(page).to have_content(proposal.answer)
  end
end