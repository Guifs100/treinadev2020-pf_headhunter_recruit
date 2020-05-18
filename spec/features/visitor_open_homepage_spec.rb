require 'rails_helper'

feature 'Visitor open homepage' do
    scenario 'successfully' do
      #arrange
      
      #act
      visit root_path
      #assert
      
      expect(page).to have_content('Bem-vindo ao Headhunter Recruit!')
    end
end