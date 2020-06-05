class Profile < ApplicationRecord
  belongs_to :candidate
  has_one_attached :photo
  has_many :apply_vacancies
  has_one :vacancy, through: :apply_vacancy
  has_one :star_profile


  validates :full_name, :social_name, :birth_date,
            :formation, :description,
            :experience, 
            :photo,
            presence: {message: "%{attribute} não pode ficar em branco"}

end
