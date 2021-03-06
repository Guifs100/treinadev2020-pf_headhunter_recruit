require 'rails_helper'

feature 'Headhunter authentication' do
  context 'log in' do
    scenario 'successufully' do
      #Arrange

      #Act
      visit root_path
      click_on 'Criar uma conta Headhunter'
      fill_in 'Email', with: 'test@headhunter.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmação de senha', with: '12345678'
      click_on 'Cadastrar'

      #Assert
      expect(page).to have_content('Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.')
      expect(Headhunter.count).to eq 1


    end

    scenario 'and fields cannot be blank' do
      #arrange
      #act
      visit root_path
      click_on 'Criar uma conta Headhunter'
      click_on 'Cadastrar'

      #assert
      expect(page).to have_content('Email não pode ficar em branco')
      expect(page).to have_content('Senha não pode ficar em branco')

    end

  end

end