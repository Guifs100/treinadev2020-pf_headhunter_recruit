require 'rails_helper'

RSpec.describe RejectApplyVacancy, type: :model do
  it 'Feedback cannot be blank' do
    reject_apply_vacancy = RejectApplyVacancy.new

    reject_apply_vacancy.valid?

    expect(reject_apply_vacancy.errors[:feedback]).to include('Feedback não pode '\
                                                  'ficar em branco')
  end
end
