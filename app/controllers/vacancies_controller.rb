class VacanciesController < ApplicationController

  def show
    id = params[:id]
    @vacancy = Vacancy.find(id)
  end

  def new
    @vacancy = Vacancy.new
    @levels = Level.all
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)
    @vacancy.headhunter = current_headhunter
    if @vacancy.save
      flash[:notice] = 'Vaga criada com sucesso'
      @vacancy.available!
      redirect_to @vacancy
    else
      @levels = Level.all
      render new_vacancy_path
    end
  end


  private 

  def vacancy_params
    params.require(:vacancy).permit(:title, :job_description,
                                    :skills, :salary,
                                    :registration_date,
                                    :address, :level_id)
  end

end