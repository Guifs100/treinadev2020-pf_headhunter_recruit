class Vacancy < ApplicationRecord
  belongs_to :headhunter
  belongs_to :level
  has_many :apply_vacancies
  has_one :profile, through: :apply_vacancy



  validates :title, :job_description, :skills, :salary,
            :registration_date, :address, 
            presence: true

  enum status: {available: 0, unavailable: 5}

  scope :search, ->(query) {where('title LIKE ? AND status = ?', "%#{query}%", Vacancy.statuses[:available] )
                              .or(where('job_description LIKE ? AND status = ?', "%#{query}%", Vacancy.statuses[:available] ))}                              

end
