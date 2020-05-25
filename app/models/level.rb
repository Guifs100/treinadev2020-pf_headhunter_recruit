class Level < ApplicationRecord
  has_many :vacancies
  
  validates :name, presence: {message: 'Nome não pode ficar em branco'}
  validates :name, uniqueness: {message: 'Nome deve ser único'}
end
