class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_one :photo, through: :profile

  validates :email, presence: {message: 'Email não pode ficar em branco'}
  validates :email, uniqueness: {message: 'Email deve ser único'}
end
