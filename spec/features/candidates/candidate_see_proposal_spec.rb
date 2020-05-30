require 'rails_helper'

feature 'Candidate see proposal' do
  let(:profile) {create :profile, :with_photo}
  context 'successfully' do
    scenario 'in root path' do
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
      click_on 'Minhas Propostas'
      within "div#proposal-#{ proposal.id}" do
        click_on 'Ver Proposta'
      end

      expect(page).to have_content('Propostas')
      expect(page).to have_content(vacancy.title)
      expect(page).to have_content(vacancy.job_description)
      expect(page).to have_content(vacancy.level.name)
      expect(page).to have_content('Data de Início')
      expect(page).to have_content(I18n.l(Time.zone.today + 10.days))
      expect(page).to have_content('Salário: R$ 1.200,00')
      expect(page).to have_content('Benefícios: VA, VR, vale-transporte')
      expect(page).to have_content('Funções: Desenvolver o back-end do projeto Rental Cars com Rails')
      expect(Proposal.count).to eq 1

      expect(page).not_to have_content(other_vacancy.title)
      expect(page).not_to have_content(other_vacancy.job_description)
    end

    scenario 'in all proposals' do
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
      click_on 'Minhas Propostas'

      expect(page).to have_content('Propostas')
      expect(page).to have_content(vacancy.title)
      expect(page).to have_content(vacancy.job_description)
      expect(page).to have_content('Data de Início')
      expect(page).to have_content(I18n.l(Time.zone.today + 10.days))
      expect(page).to have_link('Ver Proposta')
      expect(Proposal.count).to eq 1

      expect(page).not_to have_content(other_vacancy.title)
      expect(page).not_to have_content(other_vacancy.job_description)
    end

    xscenario 'in my vacancy send to proposal' do
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
      within "div#applied-vacancy-#{ apply_vacancy.id}" do
        click_on 'Ver Proposta'
      end

      expect(page).to have_content('Propostas')
      expect(page).to have_content(vacancy.title)
      expect(page).to have_content(vacancy.job_description)
      expect(page).to have_content(vacancy.level.name)
      expect(page).to have_content('Data de Início')
      expect(page).to have_content(I18n.l(Time.zone.today + 10.days))
      expect(page).to have_content('Salário: R$ 1.200,00')
      expect(page).to have_content('Benefícios: VA, VR, vale-transporte')
      expect(page).to have_content('Funções: Desenvolver o back-end do projeto Rental Cars com Rails')
      expect(Proposal.count).to eq 1

      expect(page).not_to have_content(other_vacancy.title)
      expect(page).not_to have_content(other_vacancy.job_description)
    end

    scenario 'in vacancy send to proposals' do
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

      expect(page).to have_content('Propostas')
      expect(page).to have_content(vacancy.title)
      expect(page).to have_content(vacancy.job_description)
      expect(page).to have_content(vacancy.level.name)
      expect(page).to have_content('Data de Início')
      expect(page).to have_content(I18n.l(Time.zone.today + 10.days))
      expect(page).to have_content('Salário: R$ 1.200,00')
      expect(page).to have_content('Benefícios: VA, VR, vale-transporte')
      expect(page).to have_content('Funções: Desenvolver o back-end do projeto Rental Cars com Rails')
      expect(Proposal.count).to eq 1
    end
  end

end