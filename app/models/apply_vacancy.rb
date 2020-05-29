class ApplyVacancy < ApplicationRecord
  belongs_to :profile
  belongs_to :vacancy
  has_one :star_profile, through: :profile


  validates :apply_message, presence: true

  scope :applied_vacancies, ->(vacancy) {where('vacancy_id = ? ', vacancy)}

end
