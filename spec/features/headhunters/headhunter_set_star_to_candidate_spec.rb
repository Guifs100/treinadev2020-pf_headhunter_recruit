require 'rails_helper'

feature 'Headhunter set star to candidate' do
  let(:profile) {create :profile, :with_photo}
  let(:other_profile) {create :profile, :with_photo}
  context 'succssfully' do
    scenario 'in profile view' do
      headhunter = create(:headhunter, email: 'test@headhunter.com',
                                       password: '12345678')
      candidate = create(:candidate, email: 'test@headhunter.com',
                                     password: '12345678')
      profile.candidate = candidate
      level = create(:level, name: 'Júnior')
      vacancy = create(:vacancy, level: level, headhunter: headhunter)
      apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
      
      login_as headhunter, scope: :headhunter
      visit profile_path(apply_vacancy.profile.id)
      click_on 'Favoritar Perfil'

      expect(page).to have_content('Perfil Favoritado com sucesso')
      expect(page).to have_content('Perfil Favorito')
      expect(current_path).to eq(profile_path(profile.id))

    end

    xscenario 'in vacancy view' do
    end
  end

  scenario 'and remove the star' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                     password: '12345678')
    candidate = create(:candidate, email: 'test@headhunter.com',
                                   password: '12345678')
    profile.candidate = candidate
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    star_profile = create(:star_profile, profile: profile, headhunter: headhunter)
    
    login_as headhunter, scope: :headhunter
    visit profile_path(apply_vacancy.profile.id)
    click_on 'Desfavoritar Perfil'

    expect(page).to have_content('Perfil Desfavoritado com sucesso')
    expect(StarProfile.count).to eq 0
    expect(current_path).to eq(profile_path(profile.id))

  end

  scenario 'and remove the star and favorite again' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                     password: '12345678')
    candidate = create(:candidate, email: 'test@headhunter.com',
                                   password: '12345678')
    profile.candidate = candidate
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)
    star_profile = create(:star_profile, profile: profile, headhunter: headhunter)
    
    login_as headhunter, scope: :headhunter
    visit profile_path(apply_vacancy.profile.id)
    click_on 'Desfavoritar Perfil'
    click_on 'Favoritar Perfil'

    expect(page).to have_content('Perfil Favoritado com sucesso')
    expect(page).to have_content('Perfil Favorito')
    expect(current_path).to eq(profile_path(profile.id))
  end

  scenario 'and view favorite in vacancy' do
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

    expect(page).to have_content('Perfil Favorito')
    expect(StarProfile.count).to eq 1
  end
end