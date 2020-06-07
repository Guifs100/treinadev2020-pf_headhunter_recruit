require 'rails_helper'

feature 'Candidate apply a vacancy' do
  scenario 'successfully' do
    level = create(:level, name: 'Junior')
    other_level = create(:level, name: 'Senior')
    headhunter = create(:headhunter)
    vacancy = Vacancy.create!( title: "Desenvolvedor Junior",
                               job_description: "Trabalhar em equipe e disciplina",
                               skills: "Ruby, Rails, Banco de Dados",
                               salary: 1200,
                               level: level,
                               registration_date: 10.days.from_now,
                               address: "Av. Paulista, 1234 SP",
                               headhunter: headhunter,
                               status: 0)
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))
    
    login_as candidate, scope: :candidate
    visit root_path
    within "div#vacancy-#{vacancy.id}" do
      click_on 'Ver Detalhes'
    end
    click_on 'Candidatar'
    fill_in 'Mensagem', with:'Tenho 5 anos de experiência em Ruby on Rails'
    click_on 'Enviar'

    expect(page).to have_content('Cadastrado com sucesso!')
    expect(page).to have_content('Tenho 5 anos de experiência em Ruby on Rails')
    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.skills)
    expect(page).to have_content('R$ 1.200,00')
    expect(page).to have_content(vacancy.level.name)
  end

  scenario 'message cannot be blank' do
    level = create(:level, name: 'Junior')
    other_level = create(:level, name: 'Senior')
    headhunter = create(:headhunter)
    vacancy = Vacancy.create!( title: "Desenvolvedor Junior",
                               job_description: "Trabalhar em equipe e disciplina",
                               skills: "Ruby, Rails, Banco de Dados",
                               salary: 1200,
                               level: level,
                               registration_date: 10.days.from_now,
                               address: "Av. Paulista, 1234 SP",
                               headhunter: headhunter,
                               status: 0)
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))
    
    login_as candidate, scope: :candidate
    visit root_path
    within "div#vacancy-#{vacancy.id}" do
      click_on 'Ver Detalhes'
    end
    click_on 'Candidatar'
    click_on 'Enviar'

    expect(page).to have_content('Mensagem não pode ficar em branco')
    expect(current_path).to eq(new_vacancy_apply_vacancy_path(vacancy.id))
    
  end

  scenario 'see applied vacancies' do
    level = create(:level, name: 'Junior')
    other_level = create(:level, name: 'Senior')
    headhunter = create(:headhunter)
    vacancy = Vacancy.create!( title: "Desenvolvedor Junior",
                               job_description: "Trabalhar em equipe e disciplina",
                               skills: "Ruby, Rails, Banco de Dados",
                               salary: 1200,
                               level: level,
                               registration_date: 10.days.from_now,
                               address: "Av. Paulista, 1234 SP",
                               headhunter: headhunter,
                               status: 0)
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))
    apply_vacancy = ApplyVacancy.create!(profile: profile, vacancy: vacancy,
                                         apply_message: 'Tenho 5 anos de experiência em Ruby on Rails' )
    
    login_as candidate, scope: :candidate
    visit root_path    
    click_on 'Minhas Vagas'

    expect(page).to have_content(apply_vacancy.apply_message)
    expect(page).to have_content(apply_vacancy.vacancy.title)
    expect(page).to have_content(apply_vacancy.vacancy.job_description)
  end

  scenario 'cannot apply to the same vacancy' do
    level = create(:level, name: 'Junior')
    other_level = create(:level, name: 'Senior')
    headhunter = create(:headhunter)
    vacancy = Vacancy.create!( title: "Desenvolvedor Junior",
                               job_description: "Trabalhar em equipe e disciplina",
                               skills: "Ruby, Rails, Banco de Dados",
                               salary: 1200,
                               level: level,
                               registration_date: 10.days.from_now,
                               address: "Av. Paulista, 1234 SP",
                               headhunter: headhunter,
                               status: 0)
    other_vacancy = Vacancy.create!( title: "Programador Senior",
                                     job_description: "Proatividade e compromisso para desenvolver com a equipe",
                                     skills: "SQL, C, Java",
                                     salary: 2400,
                                     level: other_level,
                                     registration_date: 10.days.from_now,
                                     address: "Av. Paulista, 1234 SP",
                                     headhunter: headhunter,
                                     status: 0)
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))
    apply_vacancy = ApplyVacancy.create!(profile: profile, vacancy: vacancy,
                                         apply_message: 'Tenho 5 anos de experiência em Ruby on Rails' )
    
    login_as candidate, scope: :candidate
    visit root_path    

    expect(page).not_to have_content(vacancy.title)
    expect(page).not_to have_content(vacancy.job_description)
    expect(page).not_to have_content(vacancy.level.name)
    expect(page).to have_content(other_vacancy.title)
    expect(page).to have_content(other_vacancy.job_description)
    expect(page).to have_content(other_vacancy.level.name)
  end
end