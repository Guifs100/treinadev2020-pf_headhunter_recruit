require 'rails_helper'

RSpec.describe Proposal, type: :model do
  it 'Start date cannot be blank' do
    proposal = Proposal.new

    proposal.valid?

    expect(proposal.errors[:start_date]).to include('Data de Início não pode '\
                                                  'ficar em branco')
  end

  it 'Salary cannot be blank' do
    proposal = Proposal.new

    proposal.valid?

    expect(proposal.errors[:salary]).to include('Salário não pode '\
                                                  'ficar em branco')
  end

  it 'Benefits cannot be blank' do
    proposal = Proposal.new

    proposal.valid?

    expect(proposal.errors[:benefits]).to include('Benefícios não pode '\
                                                  'ficar em branco')
  end

  it 'Job functions cannot be blank' do
    proposal = Proposal.new

    proposal.valid?

    expect(proposal.errors[:job_functions]).to include('Funções não pode '\
                                                  'ficar em branco')
  end
end
