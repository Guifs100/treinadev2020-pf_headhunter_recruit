require 'rails_helper'

feature 'Headhunter register vacancy' do
  scenario 'successfully' do
    #arrange
    # headhunter = create(:headhunter)
    headhunter = Headhunter.create( email: 'test@headhunter.com',
                                    password: '12345678')

    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Cadastrar nova vaga'
    fill_in 'Título', with: 'Desenvolvedor Ruby jr.'
    fill_in 'Descrição da vaga', with: 'Desevolvedor terá treino e conhecera cultura da empresa'
    fill_in 'Habilidades Necessárias', with: 'Ruby, ruby on Rails, banco de dados.'
    fill_in 'Salário', with: '2400'
    fill_in 'Nível da vaga', with: 'Júnior'
    fill_in 'Data limite da inscrição', with: 2.days.from_now
    fill_in 'Endereço', with: 'Av. Paulista'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Título: criada com sucesso')
    expect(page).to have_content('Descrição da vaga: Desevolvedor terá treino e conhecera cultura da empresa')
    expect(page).to have_content('Habilidades necessárias: Ruby, ruby on Rails, banco de dados.')
    expect(page).to have_content('Sálario: R$ 1.200,00')
    expect(page).to have_content('Nível da vaga: Júnior')
    expect(page).to have_content("Data limite da inscrição: #{2.days.from_now}")
    expect(page).to have_content('Endereço: Av. Paulista')
    
  end

  # xscenario 'and must fill in all fields' do
    #arrange
    #act
    #assert
  # end

  # xscenario 'and name can be unique' do
    #arrange
    #act
    #assert
  # end
end