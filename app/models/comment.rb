class Comment < ApplicationRecord
  belongs_to :headhunter
  belongs_to :profile

  validates :text, presence: {message: 'Comentário não pode ficar em branco'}

  scope :search_comments, ->(profile_id, headhunter_id) {where('profile_id = ? AND headhunter_id = ? ', profile_id, headhunter_id)}
  
end
