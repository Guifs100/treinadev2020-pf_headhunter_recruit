class Vacancy < ApplicationRecord
  belongs_to :headhunter
  belongs_to :level

  validates :title, :job_description, :skills, :salary,
            :registration_date, :address, 
            presence: true

  enum status: {available: 0, unavailable: 5}



end
