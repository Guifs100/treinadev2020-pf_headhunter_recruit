require 'rails_helper'

feature 'Headhunter consult vancancies' do
  scenario 'successfully' do
    #arrange
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, title:  "Desenvolvedor Junior",
                                job_description:  "Trabalhar em equipe, proatividade e disciplina",
                                skills:  "Ruby, Rails, Banco de Dados",
                                salary:  1200,
                                level: level,
                                registration_date: 10.days.from_now,
                                address:  "Av. Paulista, 1234 SP",
                                headhunter: headhunter)

    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Ver Minhas Vagas'
    
    #assert
    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.level.name)
  end

  scenario 'and only your vacancies' do
    #arrange
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    another_headhunter = create(:headhunter, email: 'aaa@headhunter.com',
                                      password: '12345678')
    level = create(:level, name: 'Júnior')
    another_level = create(:level, name: 'Sênior')
    vacancy = create(:vacancy, title:  "Desenvolvedor Junior",
                                job_description:  "Trabalhar em equipe, proatividade e disciplina",
                                skills:  "Ruby, Rails, Banco de Dados",
                                salary:  1200,
                                level: level,
                                registration_date: 10.days.from_now,
                                address:  "Av. Paulista, 1234 SP",
                                headhunter: headhunter)
    another_vacancy = create(:vacancy, title:  "Desenvolvedor Sênior",
                                       job_description:  "Disciplina e organização",
                                       skills:  "Ruby, Rails, Banco de Dados",
                                       salary:  1200,
                                       level: another_level,
                                       registration_date: 10.days.from_now,
                                       address:  "Av. Paulista, 1234 SP",
                                       headhunter: another_headhunter)
    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Ver Minhas Vagas'
    
    #assert
    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.level.name)
    expect(page).not_to have_content(another_vacancy.title)
    expect(page).not_to have_content(another_vacancy.job_description)
    expect(page).not_to have_content(another_vacancy.level.name)
  end

  scenario 'and only your apply_vacancies' do
    #arrange
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    candidate = create(:candidate, email: 'test@headhunter.com',
                                        password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, title:  "Desenvolvedor Junior",
                                job_description:  "Trabalhar em equipe, proatividade e disciplina",
                                skills:  "Ruby, Rails, Banco de Dados",
                                salary:  1200,
                                level: level,
                                registration_date: 10.days.from_now,
                                address:  "Av. Paulista, 1234 SP",
                                headhunter: headhunter)
    apply_vacancy = ApplyVacancy.create!(profile: profile, vacancy: vacancy,
                                         apply_message: 'Tenho 5 anos de experiência em Ruby on Rails' )

    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Ver Minhas Vagas'
    within "div#vacancy-#{vacancy.id}" do
      click_on 'Ver Detalhes'
    end
    
    #assert
    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.skills)
    expect(page).to have_content(vacancy.skills)
    expect(page).to have_content('R$ 1.200,00')
    expect(page).to have_content(vacancy.level.name)
    expect(page).to have_content(profile.full_name)
    expect(page).to have_content(profile.social_name)
    expect(page).to have_content(apply_vacancy.apply_message)
    expect(page).not_to have_content('Candidatar')

  end

  scenario 'and see details apply_vacancies' do
    #arrange
    headhunter = create(:headhunter, email: 'test@headhunter.com',
                                      password: '12345678')
    candidate = create(:candidate, email: 'test@headhunter.com',
                                        password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))
    level = create(:level, name: 'Júnior')
    vacancy = create(:vacancy, title:  "Desenvolvedor Junior",
                                job_description:  "Trabalhar em equipe, proatividade e disciplina",
                                skills:  "Ruby, Rails, Banco de Dados",
                                salary:  1200,
                                level: level,
                                registration_date: 10.days.from_now,
                                address:  "Av. Paulista, 1234 SP",
                                headhunter: headhunter)
    apply_vacancy = ApplyVacancy.create!(profile: profile, vacancy: vacancy,
                                         apply_message: 'Tenho 5 anos de experiência em Ruby on Rails' )

    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Ver Minhas Vagas'
    within "div#vacancy-#{vacancy.id}" do
      click_on 'Ver Detalhes'
    end
    within "div#applied-vacancy-#{apply_vacancy.id}" do
      click_on 'Ver Perfil'
    end
    
    #assert
    expect(page).to have_content(profile.full_name)
    expect(page).to have_content(profile.social_name)
    expect(page).to have_content(I18n.l(profile.birth_date))
    expect(page).to have_content(profile.formation)
    expect(page).to have_content(profile.description)
    expect(page).to have_content(profile.experience)
  end
end