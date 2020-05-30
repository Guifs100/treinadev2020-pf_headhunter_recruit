require 'rails_helper'

feature 'Headhunter send proposal' do
  let(:profile) {create :profile, :with_photo}
  let(:other_profile) {create :profile, :with_photo}
  scenario 'successfully' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    candidate = create(:candidate, email: 'test@candidate.com',
                                    password: '12345678')
    profile.candidate = candidate
    other_candidate = create(:candidate, email: 'test1@candidate.com',
                                          password: '12345678')
    other_profile.candidate = other_candidate
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    other_apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    star_profile = create(:star_profile, profile: profile, headhunter: headhunter)
    
    login_as headhunter, scope: :headhunter
    visit vacancy_path(vacancy.id)
    within "div#applied-vacancy-#{ apply_vacancy.id }" do
      click_on 'Enviar Proposta'
    end
    fill_in 'Data de Início', with: 10.days.from_now
    fill_in 'Salário', with: 1200
    fill_in 'Benefícios', with: 'VA, VR, vale-transporte'
    fill_in 'Funções', with: 'Desenvolver o back-end do projeto Rental Cars com Rails'
    click_on 'Enviar'

    expect(page).to have_content('Proposta Enviada')
    expect(page).to have_content(I18n.l(Time.zone.today + 10.days))
    expect(Proposal.count).to eq 1
    expect(page).to have_content('Salário: R$ 1.200,00')
    expect(page).to have_content('Benefícios: VA, VR, vale-transporte')
    expect(page).to have_content('Funções: Desenvolver o back-end do projeto Rental Cars com Rails')

  end

  scenario 'and must fill in all' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    candidate = create(:candidate, email: 'test@candidate.com',
                                    password: '12345678')
    profile.candidate = candidate
    other_candidate = create(:candidate, email: 'test1@candidate.com',
                                          password: '12345678')
    other_profile.candidate = other_candidate
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    other_apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    star_profile = create(:star_profile, profile: profile, headhunter: headhunter)
    
    login_as headhunter, scope: :headhunter
    visit vacancy_path(vacancy.id)
    within "div#applied-vacancy-#{ apply_vacancy.id }" do
      click_on 'Enviar Proposta'
    end
    click_on 'Enviar'

    expect(page).to have_content('Campo(s) não pode ficar em branco')
    # expect(page).to have_content('Data de Início não pode ficar em branco')
    # expect(page).to have_content('Salário não pode ficar em branco')
    # expect(page).to have_content('Benefícios não pode ficar em branco')
    # expect(page).to have_content('Funções não pode ficar em branco')

  end
end