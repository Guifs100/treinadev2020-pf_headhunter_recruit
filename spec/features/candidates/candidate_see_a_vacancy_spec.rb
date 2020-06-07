require 'rails_helper'

feature 'Candidate see a vacancy' do
  # let(:profile) {build :profile, :with_photo}
  # let(:profile) {build_stubbed :profile, :with_photo}
  let(:profile) {create :profile, :with_photo}
  scenario 'successufully' do
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
                                     job_description: "Proatividade e compromisso",
                                     skills: "SQL, C, Java",
                                     salary: 2400,
                                     level: other_level,
                                     registration_date: 10.days.from_now,
                                     address: "Av. Paulista, 1234 SP",
                                     headhunter: headhunter,
                                     status: 5)
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    other_candidate = Candidate.create!(email: 'teste1@candidate.com', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))

    login_as candidate, scope: :candidate
    visit root_path
    # save_page

    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.level.name)
    expect(page).not_to have_content(other_vacancy.title)
    expect(page).not_to have_content(other_vacancy.job_description)
    expect(page).not_to have_content(other_vacancy.level.name)
  end

  scenario 'see vacancy details' do
    level = create(:level, name: 'Junior')
    other_level = create(:level, name: 'Senior')
    headhunter = create(:headhunter)
    vacancy = Vacancy.create!( title: "Desenvolvedor Junior",
                               job_description: "Trabalhar em equipe e disciplina",
                               skills: "Ruby, Rails, Banco de Dados",
                               salary: 2400,
                               level: level,
                               registration_date: 10.days.from_now,
                               address: "Av. Paulista, 1234 SP",
                               headhunter: headhunter,
                               status: 0)
    candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    profile.candidate = candidate
    profile.full_name = "Fulano Silva"
    profile.social_name = "Fulano"
    profile.birth_date = '15/11/1996'
    profile.formation = 'Análise e desenvolvimento de sistemas'
    profile.description = 'Formado na Fatec'
    profile.experience = 'Nenhuma'

    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Ver Detalhes'

    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.skills)
    expect(page).to have_content('R$ 2.400,00')
    expect(page).to have_content(vacancy.level.name)
    expect(page).to have_content(I18n.l(Time.zone.today + 10.days))
    expect(page).to have_content(vacancy.address)
  end

  scenario 'search a vacancy' do
    level = create(:level, name: 'Junior')
    other_level = create(:level, name: 'Senior')
    headhunter = create(:headhunter)
    vacancy = Vacancy.create!( title: "desenvolvedor Junior",
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
    another_vacancy = Vacancy.create!( title: "Programador Pleno",
                                        job_description: "Trabalho remoto",
                                        skills: "SQL, C, Java",
                                        salary: 2400,
                                        level: other_level,
                                        registration_date: 10.days.from_now,
                                        address: "Av. Paulista, 1234 SP",
                                        headhunter: headhunter,
                                        status: 5)
    another_vacancy2 = Vacancy.create!( title: "Programador Pleno",
                                       job_description: "Proatividades ",
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

    login_as candidate, scope: :candidate
    visit root_path
    fill_in 'Procurar Vagas', with: 'Junior'
    click_on 'Buscar'

    expect(page).to have_content(vacancy.title)
    expect(page).to have_content(vacancy.job_description)
    expect(page).to have_content(vacancy.level.name)
    expect(current_path).to eq(search_vacancies_path)
    expect(page).to have_content('Vagas Buscadas')

    expect(page).not_to have_content(other_vacancy.title)
    expect(page).not_to have_content(other_vacancy.job_description)
    expect(page).not_to have_content(another_vacancy.title)
    expect(page).not_to have_content(another_vacancy.job_description)
    expect(page).not_to have_content(another_vacancy2.title)
    expect(page).not_to have_content(another_vacancy2.job_description)
  end
end