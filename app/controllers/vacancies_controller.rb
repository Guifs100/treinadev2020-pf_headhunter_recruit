class VacanciesController < ApplicationController

  def new
    @vacancy = Vacancy.new
  end

  

end