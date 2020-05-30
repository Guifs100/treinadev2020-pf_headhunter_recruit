class RejectApplyVacancy < ApplicationRecord
  belongs_to :headhunter
  belongs_to :apply_vacancy
  has_one :profile, through: :apply_vacancy

  validates :feedback, presence: true

  scope :reject_applies, -> () {joins(:profile)}

end
