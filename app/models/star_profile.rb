class StarProfile < ApplicationRecord
  belongs_to :headhunter
  belongs_to :profile

  scope :search, ->(profile_id, headhunter_id) {where('profile_id = ? AND headhunter_id = ? ', profile_id, headhunter_id).take}

end
