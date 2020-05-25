require 'rails_helper'

RSpec.describe Headhunter, type: :model do
  context 'validation' do
    it 'email cannot be blank' do
      headhunter = Headhunter.new

      headhunter.valid?

      expect(headhunter.errors[:email]).to include('Email não pode '\
                                                    'ficar em branco')
    end
    it 'email must be uniq' do
      Headhunter.create!(email: 'aaa@headhunter.com', password: '12345678')
      headhunter = Headhunter.new(email: 'aaa@headhunter.com', password: '12345678')

      headhunter.valid?

      expect(headhunter.errors[:email]).to include('Email deve ser único')
    end
  end
end
