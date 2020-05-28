class ApplyVacancy < ApplicationRecord
  belongs_to :profile
  belongs_to :vacancy


  scope :applied_vacancies, ->(vacancy) {where('vacancy_id = ? ', vacancy)}

end
