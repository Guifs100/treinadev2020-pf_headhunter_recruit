class Proposal < ApplicationRecord
  belongs_to :headhunter
  belongs_to :apply_vacancy

  validates :start_date, :salary,
            :benefits, :job_functions,
            presence: true

end
