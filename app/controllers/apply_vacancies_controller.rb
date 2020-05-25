class ApplyVacanciesController < ApplicationController
  
  
  
  def show    
    @apply_vacancy = ApplyVacancy.find(params[:id])
  end
  
  def new
    @vacancy = Vacancy.find(params[:vacancy_id])
    @apply_vacancy = ApplyVacancy.new
  end

  def create
    @apply_vacancy = ApplyVacancy.new(apply_vacancy_params)
    @vacancy = Vacancy.find(params[:vacancy_id])
    @profile = Profile.find( current_candidate.id)
    @apply_vacancy.profile = @profile
    @apply_vacancy.vacancy =  @vacancy
    if @apply_vacancy.save
      flash[:notice] = 'Cadastrado com sucesso!'
      redirect_to vacancy_apply_vacancy_path(@vacancy, @apply_vacancy)
    else
      redirect_to @vacancy
    end
  end

  private

  def apply_vacancy_params
    params.require(:apply_vacancy).permit(:apply_message)
  end
end