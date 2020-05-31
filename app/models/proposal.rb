class Proposal < ApplicationRecord
  belongs_to :headhunter
  belongs_to :apply_vacancy
  has_one :profile, through: :apply_vacancy

  validates :start_date, :salary,
            :benefits, :job_functions,
            presence: true

  enum status: {initial: 0, accepted: 5, rejected: 10}


 scope :profile_proposals, -> () {joins(:profile)}
 scope :response_proposals, -> (headhunter_id) {where.not(status: :initial)
                                    .joins(:headhunter).where('headhunter_id = ?', headhunter_id)}

            

end
