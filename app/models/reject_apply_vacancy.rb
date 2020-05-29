class RejectApplyVacancy < ApplicationRecord
  belongs_to :headhunter
  belongs_to :apply_vacancy

  validates :feedback, presence: true
end
