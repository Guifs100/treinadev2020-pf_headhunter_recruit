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
    
    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.level.name)
    expect(page).not_to have_content(another_vacancy.title)
    expect(page).not_to have_content(another_vacancy.job_description)
    expect(page).not_to have_content(another_vacancy.level.name)
  end
end