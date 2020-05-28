require 'rails_helper'

feature 'Headhunter write a comment' do
  let(:profile) {create :profile, :with_photo}
  scenario 'successfully' do
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                     password: '12345678')
    candidate = create(:candidate, email: 'test@headhunter.com',
                                   password: '12345678')
    profile.candidate = candidate
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, level: level, headhunter: headhunter)
    apply_vacancy = create(:apply_vacancy, profile: profile, vacancy: vacancy)

    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Ver Minhas Vagas'
    within "div#vacancy-#{vacancy.id}" do
    click_on 'Ver Detalhes'
    end
    within "div#applied-vacancy-#{apply_vacancy.id}" do
    click_on 'Ver Perfil'
    end
    # visit profile_path(apply_vacancy.profile.id)
    click_on 'Novo Comentário'
    fill_in 'Comentário', with: 'Perfil interessante!'
    click_on 'Enviar'

    expect(page).not_to have_link('Editar Perfil')
    expect(page).to have_content('Comentário Criado')
    expect(page).to have_content(profile.full_name)
    expect(page).to have_content(profile.social_name)
    expect(page).to have_content(I18n.l(profile.birth_date))
    expect(page).to have_content(profile.formation)
    expect(page).to have_content(profile.description)
    expect(page).to have_content(profile.experience)
    expect(page).to have_content('Perfil interessante!')
    expect(page).to have_content(I18n.l(Time.zone.now.to_date))
    expect(page).to have_content(Time.now.strftime("%H:%M"))
  end

  scenario 'successfully' do
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
    click_on 'Novo Comentário'
    click_on 'Enviar'

    expect(page).to have_content('Comentário não pode ficar em branco')
    expect(current_path).to eq(new_profile_comment_path(profile.id))
  end
end