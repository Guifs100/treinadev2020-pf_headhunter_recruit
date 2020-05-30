require 'rails_helper'

feature 'Candidate accept proposal' do
  let(:profile) {create :profile, :with_photo}

  scenario 'successfully' do
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
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Ver Propostas'
    within "div#proposal-#{ proposal.id}" do
      click_on 'Ver Proposta'
    end
    click_on 'Responder Proposta'
    select 'Aceitar', from: 'Resposta'
    fill_in 'Comentário', with: 'Aceito'
    click_on 'Enviar'

    expect(page).to have_content('Resposta Enviada ao Headhunter')
    expect(current_path).to eq(all_proposals_profiles_path)

    expect(page).not_to have_content(vacancy.title)
    expect(page).not_to have_content(vacancy.job_description)
  end

  scenario 'successfully without comment' do
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
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Ver Propostas'
    within "div#proposal-#{ proposal.id}" do
      click_on 'Ver Proposta'
    end
    click_on 'Responder Proposta'
    select 'Aceitar', from: 'Resposta'
    click_on 'Enviar'

    expect(page).to have_content('Resposta Enviada ao Headhunter')
    expect(current_path).to eq(all_proposals_profiles_path)

    expect(page).not_to have_content(vacancy.title)
    expect(page).not_to have_content(vacancy.job_description)
  end

  scenario 'must accept the proposal' do
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
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Ver Propostas'
    within "div#proposal-#{ proposal.id}" do
      click_on 'Ver Proposta'
    end
    click_on 'Responder Proposta'
    click_on 'Enviar'

    expect(page).to have_content('Precisa escolher uma resposta')
  end
end