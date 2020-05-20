class Vacancy < ApplicationRecord


  enum level: { estágio: 0, junior: 2, pleno: 4, sênior: 6, especialista: 8, diretor: 10 }

end
