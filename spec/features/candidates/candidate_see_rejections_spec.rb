require 'rails_helper'

feature 'Candidate see rejections' do
  let(:profile) {create :profile, :with_photo}
  scenario 'successfully' do
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
    reject_apply_vacancy = create(:reject_apply_vacancy, headhunter: headhunter, 
                                                         apply_vacancy: other_apply_vacancy,
                                                         feedback: 'Não se enquadra a vaga')
    
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Ver Rejeições'

    expect(page).to have_content('Rejeições')
    expect(page).to have_content(other_vacancy.title)
    expect(page).to have_content(other_vacancy.description)
    expect(page).to have_content(other_vacancy.description)
    expect(page).to have_content(reject_apply_vacancy.feedback)
  end
end