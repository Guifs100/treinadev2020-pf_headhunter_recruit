class Proposal < ApplicationRecord
  belongs_to :headhunter
  belongs_to :apply_vacancy
  has_one :profile, through: :apply_vacancy
  has_one :vacancy, through: :apply_vacancy

  validates :start_date, :salary,
            :benefits, :job_functions,
            presence: {message: "%{attribute} não pode ficar em branco"}

  enum status: {initial: 0, accepted: 5, rejected: 10}


 scope :profile_proposals, -> (profile) {joins(:apply_vacancy).where('profile_id = ?', profile.id)}
 scope :response_proposals, -> (headhunter_id) {where.not(status: :initial)
                                                .joins(:headhunter).where('headhunter_id = ?', headhunter_id)}

            

end
