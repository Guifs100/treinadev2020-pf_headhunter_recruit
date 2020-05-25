require 'rails_helper'

feature 'Headhunter authentication' do
  scenario 'successufully' do
    #Arrange
    headhunter = Headhunter.create( email: 'test@headhunter.com',
                                    password: '12345678')
    #Act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Cadastrar novo nível'
    fill_in 'Nome do nível da vaga', with: 'Estágio'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content('Level Cadastrado com sucesso!')
    expect(Level.count).to eq 1

  end
end