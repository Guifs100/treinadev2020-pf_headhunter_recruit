require 'rails_helper'

# TODO: teste para validades level
RSpec.describe Level, type: :model do
  context 'validation' do
    it 'name cannot be blank' do
      level = Level.new

      level.valid?

      expect(level.errors[:name]).to include('Nome não pode '\
                                                    'ficar em branco')
    end
    it 'name must be uniq' do
      Level.create!(name: 'Estágio')
      level = Level.new(name: 'Estágio')

      level.valid?

      expect(level.errors[:name]).to include('Nome deve ser único')
    end
  end
end
