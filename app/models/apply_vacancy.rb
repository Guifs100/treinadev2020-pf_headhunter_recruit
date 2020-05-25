class ApplyVacancy < ApplicationRecord
  belongs_to :profile
  belongs_to :vacancy
end
