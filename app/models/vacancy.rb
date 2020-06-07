class Vacancy < ApplicationRecord
  belongs_to :headhunter
  belongs_to :level
  has_many :apply_vacancies
  has_one :profile, through: :apply_vacancy



  validates :title, :job_description, :skills, :salary,
            :registration_date, :address, :level, 
            presence: {message: "%{attribute} não pode ficar em branco"}

  enum status: {available: 0, unavailable: 5}

  scope :index_candidate, -> (profile_id) {where('status = ?', Vacancy.statuses[:available])}
  scope :search, ->(q) {where('title LIKE ? AND status = ?', "%#{q}%", Vacancy.statuses[:available] )
                              .or(where('job_description LIKE ? AND status = ?', "%#{q}%", Vacancy.statuses[:available] ))}

  scope :register_vacancies, ->(headhunter) {where('headhunter_id = ? ', headhunter)}
end
