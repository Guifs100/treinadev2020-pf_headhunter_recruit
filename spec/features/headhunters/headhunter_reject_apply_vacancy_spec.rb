require 'rails_helper'

feature 'Headhunter reject apply vacancy' do
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
      click_on 'Rejeitar Perfil'
    end
    fill_in 'Feedback', with: 'Não se enquadra a vaga'
    click_on 'Enviar'

    expect(page).to have_content('Perfil Rejeitado')
    expect(ApplyVacancy.count).to eq 2
    expect(RejectApplyVacancy.count).to eq 1
    expect(current_path).to eq(vacancy_path(vacancy.id))
    # TODO: Filtrar e não exibir os rejeitados
    # expect(page).not_to have_content(profile.full_name)
    # expect(page).not_to have_content(profile.formation)
    # expect(page).not_to have_content(profile.apply_vacancy.message)
  end

  scenario 'feedback cannot be blank' do
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
      click_on 'Rejeitar Perfil'
    end
    click_on 'Enviar'

    expect(page).to have_content('Feedback não pode ficar em branco')
    # expect(current_path).to eq(vacancy_path(vacancy.id))
  end
end