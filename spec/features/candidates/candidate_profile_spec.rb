require 'rails_helper'

feature 'Candidate profile' do
  scenario 'successfully' do
    #arrange
    candidate = Candidate.create!(email: 'test@candidate', password: '12345678')

    #act
    login_as candidate, scope: :candidate
    visit root_path
    attach_file('Foto', './app/assets/images/perfil.jpg')
    fill_in 'Nome Completo', with: 'Fulano Silva'
    fill_in 'Nome Social', with: 'Fulano'
    fill_in 'Data de Nascimento', with: '15/11/1996'
    fill_in 'Formação', with: 'ADS na fatec-SP'
    fill_in 'Descrição', with: 'Determinado, proativo e trabalho em equipe'
    fill_in 'Experiência', with: 'Nenhuma'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Perfil Cadastrado')
    expect(page).to have_content('Foto:')
    expect(page).to have_css('img#perfil', count: 1)
    expect(page).to have_content('Nome Completo: Fulano Silva')
    expect(page).to have_content('Nome Social: Fulano')
    expect(page).to have_content('Data de Nascimento:')
    expect(page).to have_content('15/11/1996')
    expect(page).to have_content('Formação: ADS na fatec-SP')
    expect(page).to have_content('Descrição: Determinado, proativo e trabalho em equipe')
    expect(page).to have_content('Experiência: Nenhuma')
  end

  scenario 'and must fill profile' do
    candidate = Candidate.create!(email: 'test@candidate', password: '12345678')

    #act
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Foto não pode ficar em branco')
    expect(page).to have_content('Nome Completo não pode ficar em branco')
    expect(page).to have_content('Nome Social não pode ficar em branco')
    expect(page).to have_content('Data de Nascimento não pode ficar em branco')
    expect(page).to have_content('Formação não pode ficar em branco ')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Experiência não pode ficar em branco')
  end

  scenario 'edit profile' do
    #arrange
    candidate = Candidate.create!(email: 'test@candidate', password: '12345678')
    profile = Profile.create!(candidate: candidate, full_name: "Fulano Silva", 
                              social_name: "Fulano",
                              birth_date: "15/11/1996",
                              formation: "Análise e desenvolvimento de sistemas",
                              description: "Formado na Fatec",
                              experience: "Nenhuma",
                              photo: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg'), 'image/jpg'))

    # profile = Profile.new(candidate: candidate, full_name: "Fulano Silva", 
    #                           social_name: "Fulano",
    #                           birth_date: "15/11/1996",
    #                           formation: "Análise e desenvolvimento de sistemas",
    #                           description: "Formado na Fatec",
    #                           experience: "Nenhuma")
    
    # profile.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'perfil.jpg')), filename: 'perfil.jpg')
    # profile.save

    #act
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Ver Perfil'
    click_on 'Editar Perfil'
    attach_file('Foto', './app/assets/images/perfil.jpg')
    fill_in 'Nome Completo', with: 'Alan Silva'
    fill_in 'Nome Social', with: 'Alan'
    fill_in 'Data de Nascimento', with: '15/11/1996'
    fill_in 'Formação', with: 'Ciêcia da Computação'
    fill_in 'Descrição', with: 'Dedicado e apaixonado por máquinas'
    fill_in 'Experiência', with: 'Dev junior na google por 2 anos'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Perfil Alterado')
    expect(page).to have_content('Foto:')
    expect(page).to have_css('img#perfil', count: 1)
    expect(page).to have_content('Nome Completo: Alan Silva')
    expect(page).to have_content('Nome Social: Alan')
    expect(page).to have_content('Data de Nascimento:')
    expect(page).to have_content('15/11/1996')
    expect(page).to have_content('Formação: Ciêcia da Computação')
    expect(page).to have_content('Descrição: Dedicado e apaixonado por máquinas')
    expect(page).to have_content('Experiência: Dev junior na google por 2 anos')
  end

  scenario 'and must fill profile' do
    candidate = Candidate.create!(email: 'test@candidate', password: '12345678')

    #act
    login_as candidate, scope: :candidate
    visit root_path
    click_on 'Início'

    expect(page).to have_content('Precisa Completar o perfil!')
  end
end