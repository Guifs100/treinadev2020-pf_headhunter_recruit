class Vacancy < ApplicationRecord
  belongs_to :level

  # enum status: { estágio: 0, junior: 2, pleno: 4, sênior: 6, especialista: 8, diretor: 10 }

end
