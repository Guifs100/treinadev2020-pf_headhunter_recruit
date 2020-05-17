require 'rails_helper'

feature 'View index' do
  context 'headhunter' do
    scenario 'successfully' do
      
      #arrange
      
      #act
      visit root_path
      #assert
      
      expect(page).to have_content('Bem vindo ao Headhunter Recruit')
    end
  end
end