require 'rails_helper'

feature 'Candidate applies for a vacancy' do
  scenario 'see vacancy' do
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
                               headhunter: headhunter)
    other_vacancy = Vacancy.create!( title: "Programador Senior",
                                     job_description: "Proatividade e compromisso",
                                     skills: "SQL, C, Java",
                                     salary: 2400,
                                     level: other_level,
                                     registration_date: 10.days.from_now,
                                     address: "Av. Paulista, 1234 SP",
                                     headhunter: headhunter)
    other_vacancy.status = 5
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    other_candidate = Candidate.create!(email: 'teste1@candidate.com', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: './app/assets/images/perfil.jpg')
    # profile.photo = 'assets/images/perfil.jpg'

    login_as candidate, scope: :candidate
    visit root_path

    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.skills)
    expect(page).to have_content(vacancy.salary)
  end
end