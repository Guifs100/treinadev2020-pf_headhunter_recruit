class Profile < ApplicationRecord
  belongs_to :candidate
  has_one_attached :photo

  # TODO: validar foto do perfil
  validates :full_name, :social_name, :birth_date,
            :formation, :description,
            :experience,
            # :photo,
            presence: true

end
