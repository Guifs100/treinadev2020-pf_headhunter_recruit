require 'rails_helper'

feature 'Headhunter sign up' do
  scenario 'successufully' do
    #Arrange

    #Act
    visit root_path
    click_on 'Criar uma conta'
    fill_in 'Email', with: 'test@headhunter.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmação de senha', with: '12345678'
    click_on 'Sign up'
    # fill_in 'Senha', with: '12345678'
    # fill_in 'Confirmação de Senha', with: '12345678'
    # click_on 'Cadastrar'

    expect(page).to have_content('Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.')
    # expect(Headhunter.count).to eq 1


    


    #Assert
  end
end