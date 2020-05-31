require 'rails_helper'


  # TODO: teste do lado do candidato

feature 'Headhunter close vacancy' do
  let(:profile) {create :profile, :with_photo}

  scenario 'successfully in proposal' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    other_headhunter = create(:headhunter, email: 'test1@headhunter.com',
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
                                    headhunter: other_headhunter,
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
    other_proposal = create(:proposal, start_date: 4.days.from_now,
                                       salary: 2600,
                                       benefits: 'vale-combustível',
                                       job_functions: 'Programador rails 8h diária',
                                       headhunter: other_headhunter,
                                       apply_vacancy: other_apply_vacancy)
    other_proposal.answer = 'Obrigada'
    other_proposal.rejected!

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Respostas de Propostas'
    within "div#proposal-#{ proposal.id}" do
      click_on 'Encerrar Vaga'
    end

    expect(page).to have_content('Vaga Encerrada')
    expect(current_path).to eq(answer_proposals_vacancies_path)
    expect(page).to have_content(proposal.status)
    expect(page).to have_content(proposal.answer)
  end

  xscenario 'successfully in vacancy' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    other_headhunter = create(:headhunter, email: 'test1@headhunter.com',
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
                                    headhunter: other_headhunter,
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
    other_proposal = create(:proposal, start_date: 4.days.from_now,
                                       salary: 2600,
                                       benefits: 'vale-combustível',
                                       job_functions: 'Programador rails 8h diária',
                                       headhunter: other_headhunter,
                                       apply_vacancy: other_apply_vacancy)
    other_proposal.answer = 'Obrigada'
    other_proposal.rejected!

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Ver Minhas Vagas'
    within "div#vacancy-#{ vacancy.id}" do
      click_on 'Encerrar Vaga'
    end

    expect(page).to have_content('Vaga Encerrada')
    expect(page).to have_content('Vaga encerrada com sucesso')
    expect(current_path).to eq(answer_proposals_vacancies_path)
    # expect(page).to have_content(proposal.status)
    # expect(page).to have_content(proposal.answer)
  end
end