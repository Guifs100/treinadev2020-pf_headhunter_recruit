require 'rails_helper'

feature 'Candidate profile' do
  scenario 'successfully' do
    #arrange
    candidate = Candidate.create!(email: 'test@candidate', password: '12345678')

    #act
    login_as candidate, scope: :candidate
    visit root_path
    # fill_in 'Nome Completo', with: 'Fulano Silva'
    # fill_in 'Nome Social', with: 'Fulano'
    # fill_in 'Data de Nascimento', with: '15/11/1996'
    # fill_in 'Formação', with: 'ADS na fatec-SP'
    # fill_in 'Descrição', with: 'Determinado, proativo e trabalho em equipe'
    # click_on 'Enviar'

    #assert

    expect(page).to have_content('Perfil')
  end

  # xscenario 'and must fill profile' do
    
  # end

  # xscenario 'não terminou de preencher perfil' do
    
  # end
end