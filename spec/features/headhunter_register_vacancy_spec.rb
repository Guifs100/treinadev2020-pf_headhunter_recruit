require 'rails_helper'

feature 'Headhunter register vacancy' do
  scenario 'successfully' do
    #arrange
    # headhunter = create(:headhunter)
    headhunter = Headhunter.create( email: 'test@headhunter.com',
                                    password: '12345678')
    level = create(:level, name: 'Júnior')
    # level = Level.create(name: 'Júnior')


    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Cadastrar nova vaga'
    fill_in 'Título', with: 'Desenvolvedor Ruby jr.'
    fill_in 'Descrição da vaga', with: 'Desevolvedor terá treino e conhecera cultura da empresa'
    fill_in 'Habilidades Necessárias', with: 'Ruby, ruby on Rails, banco de dados.'
    fill_in 'Salário', with: '1200'
    select 'Júnior', from: 'Nível'
    # select level.name, from: 'Nível'
    # fill_in 'Data limite da inscrição', with: '20/05/2030'
    fill_in 'Data limite da inscrição', with: 2.days.from_now
    fill_in 'Endereço', with: 'Av. Paulista'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Vaga criada com sucesso')
    expect(page).to have_content('Título: Desenvolvedor Ruby jr.')
    expect(page).to have_content('Descrição da vaga: Desevolvedor terá treino e conhecera cultura da empresa')
    expect(page).to have_content('Habilidades: Ruby, ruby on Rails, banco de dados.')
    expect(page).to have_content('Salário: R$ 1.200,00')
    expect(page).to have_content('Nível: Júnior')
    # expect(page).to have_content('Data limite da inscrição: 20/05/2030')
    expect(page).to have_content(I18n.l(Time.zone.today + 2.days))
    expect(page).to have_content('Endereço: Av. Paulista')
    
  end

  scenario 'and must fill in all fields' do
    #arrange
    # headhunter = create(:headhunter)
    headhunter = Headhunter.create( email: 'test@headhunter.com',
                                    password: '12345678')
    # level = create(:level, name: 'Júnior')
    level = Level.create(name: 'Júnior')


    #act
    login_as headhunter, scope: :headhunter
    visit root_path
    click_on 'Cadastrar nova vaga'
    
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição da vaga não pode ficar em branco')
    expect(page).to have_content('Habilidades não pode ficar em branco')
    expect(page).to have_content('Salário não pode ficar em branco')
    expect(page).to have_content('Data limite da inscrição não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  # xscenario 'and name can be unique' do
    #arrange
    #act
    #assert
  # end
end