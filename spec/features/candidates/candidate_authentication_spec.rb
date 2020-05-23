require 'rails_helper'

feature 'Candidate authentication' do
  context 'log in' do
    scenario 'successufully' do
      #Arrange
      

      #Act
      visit root_path
      click_on 'Criar uma conta Candidato'
      fill_in 'Email', with: 'test@headhunter.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmação de senha', with: '12345678'
      click_on 'Cadastrar'

      #Assert
      expect(page).to have_content('Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.')
      expect(Candidate.count).to eq 1


    end

    scenario 'and fields cannot be blank' do
      #arrange
      #act
      visit root_path
      click_on 'Criar uma conta Candidato'
      click_on 'Cadastrar'

      #assert
      expect(page).to have_content('Email não pode ficar em branco')
      expect(page).to have_content('Senha não pode ficar em branco')

    end

    # TODO: não aparecer logar quando logado  como headhunter ou candidate
    xscenario 'and email is unique' do
      
    end
  end

  xcontext 'log in' do
    scenario 'successfully' do
      
      #arrange
    #   candidate = Candidate.create!(email: 'teste@candidate.com', password: '12345678')
    # other_candidate = Candidate.create!(email: 'teste1@candidate.com', password: '12345678')
    # # profile = create(:profile, candidate: candidate)
    # # candidate.profile = profile
    # profile = Profile.create!(candidate: other_candidate, full_name: "Fulano Silva", 
    #                           social_name: "Fulano",
    #                           birth_date: "15/11/1996",
    #                           formation: "Análise e desenvolvimento de sistemas",
    #                           description: "Formado na Fatec",
    #                           experience: "Nenhuma")
    #                           # photo: 'assets/images/perfil.jpg')
    # profile.photo = 'assets/images/perfil.jpg'

    # login_as candidate, scope: :candidate
    # visit root_path

    # expect(page).to have_content(vacancy.title)
      
      #act
      visit root_path
      #assert
      
      expect(page).to have_content('Bem vindo ao Headhunter Recruit')
    end
  end
end