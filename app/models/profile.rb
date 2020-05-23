class Profile < ApplicationRecord
  belongs_to :candidate
  has_one_attached :photo

  validates :full_name, :social_name, :birth_date,
            :photo, :formation, :description,
            :experience,
            presence: true

end
