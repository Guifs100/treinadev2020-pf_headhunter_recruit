require 'rails_helper'

RSpec.describe Candidate, type: :model do
  context 'validation' do
    it 'email cannot be blank' do
      candidate = Candidate.new

      candidate.valid?

      expect(candidate.errors[:email]).to include('Email não pode '\
                                                    'ficar em branco')
    end
    it 'email must be uniq' do
      Candidate.create!(email: 'aaa@candidate.com', password: '12345678')
      candidate = Candidate.new(email: 'aaa@candidate.com', password: '12345678')

      candidate.valid?

      expect(candidate.errors[:email]).to include('Email deve ser único')
    end
  end
end
