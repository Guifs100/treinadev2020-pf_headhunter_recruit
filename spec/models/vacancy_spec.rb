require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  it 'Title cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:title]).to include('Título não pode '\
                                                  'ficar em branco')
  end

  it 'Job description cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:job_description]).to include('Descrição da Vaga não pode '\
                                                  'ficar em branco')
  end

  it 'Habilidades cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:skills]).to include('Habilidades não pode '\
                                                  'ficar em branco')
  end

  it 'Salary cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:salary]).to include('Salário não pode '\
                                                  'ficar em branco')
  end

  it 'Registration date cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:registration_date]).to include('Data limite da inscrição não pode '\
                                                  'ficar em branco')
  end

  it 'Address cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:address]).to include('Endereço não pode '\
                                                  'ficar em branco')
  end

  it 'Level cannot be blank' do
    vacancy = Vacancy.new

    vacancy.valid?

    expect(vacancy.errors[:level]).to include('Nível não pode '\
                                                  'ficar em branco')
  end
end
