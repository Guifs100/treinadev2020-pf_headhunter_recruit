class VacanciesController < ApplicationController
  before_action :authorized_headhunter, only: %i[ headhunter_vacancies answer_proposals close_vacancy ] 
  before_action :authorized_candidate, only: %i[ search ] 

  def show
    id = params[:id]
    @vacancy = Vacancy.find(id)
    @apply_vacancies =  ApplyVacancy.applied_vacancies(@vacancy)
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

  def search
    # byebug
    @vacancies = Vacancy.search(params[:q])
    # @candidate = current_candidate
    # render 'candidates_home/index'
  end

  def headhunter_vacancies
    @headhunter_id = current_headhunter.id
    @vacancies = Vacancy.register_vacancies(@headhunter_id)
  end

  def answer_proposals
    @headhunter = current_headhunter
    @proposals = Proposal.response_proposals(@headhunter.id)
  end

  def close_vacancy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.unavailable!
    redirect_to answer_proposals_vacancies_path flash: {notice: 'Vaga encerrada com sucesso'}
  end

  private 

  def vacancy_params
    params.require(:vacancy).permit(:title, :job_description,
                                    :skills, :salary,
                                    :registration_date,
                                    :address, :level_id)
  end

end