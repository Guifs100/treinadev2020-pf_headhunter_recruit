class RejectApplyVacancy < ApplicationRecord
  belongs_to :headhunter
  belongs_to :apply_vacancy
  has_one :profile, through: :apply_vacancy

  validates :feedback, presence: {message: 'Feedback não pode ficar em branco'}

  scope :reject_applies, -> (profile) {joins(:profile).where('profile_id = ?', profile.id )}

end
