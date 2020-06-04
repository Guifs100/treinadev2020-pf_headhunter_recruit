require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'Full name cannot be blank' do
    profile = Profile.new

    profile.valid?

    expect(profile.errors[:full_name]).to include('Nome Completo não pode '\
                                                  'ficar em branco')
  end
  it 'Social name cannot be blank' do
    profile = Profile.new

    profile.valid?

    expect(profile.errors[:social_name]).to include('Nome Social não pode '\
                                                  'ficar em branco')
  end
  it 'Birth date cannot be blank' do
    profile = Profile.new

    profile.valid?

    expect(profile.errors[:birth_date]).to include('Data de Nascimento não pode '\
                                                  'ficar em branco')
  end
  it 'Formation cannot be blank' do
    profile = Profile.new

    profile.valid?

    expect(profile.errors[:formation]).to include('Formação não pode '\
                                                  'ficar em branco')
  end
  it 'Description cannot be blank' do
    profile = Profile.new

    profile.valid?

    expect(profile.errors[:description]).to include('Descrição não pode '\
                                                  'ficar em branco')
  end
  it 'Experience cannot be blank' do
    profile = Profile.new

    profile.valid?

    expect(profile.errors[:experience]).to include('Experiência não pode '\
                                                  'ficar em branco')
  end
end
