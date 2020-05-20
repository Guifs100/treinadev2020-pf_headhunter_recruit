class Vacancy < ApplicationRecord
  belongs_to :level

  validates :title, :job_description, :skills, :salary,
            :registration_date, :address, 
            presence: true

  # enum status: { estágio: 0, junior: 2, pleno: 4, sênior: 6, especialista: 8, diretor: 10 }



end
