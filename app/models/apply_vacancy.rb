class ApplyVacancy < ApplicationRecord
  belongs_to :profile
  belongs_to :vacancy

  validates :apply_message, presence: true

  scope :applied_vacancies, ->(vacancy) {where('vacancy_id = ? ', vacancy)}

end
