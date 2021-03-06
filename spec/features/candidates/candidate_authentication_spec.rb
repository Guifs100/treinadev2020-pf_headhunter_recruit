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
  end
end