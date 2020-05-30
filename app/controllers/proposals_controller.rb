class ProposalsController < ApplicationController
  before_action :authorized_headhunter

  def show
    @proposal = Proposal.find(params[:id])
    @vacancy = Vacancy.find(params[:vacancy_id])
    @apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
  end

  def new
    @vacancy = Vacancy.find(params[:vacancy_id])
    @apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
    @proposal.headhunter = current_headhunter
    if @proposal.save
      redirect_to vacancy_apply_vacancy_proposal_path(params[:vacancy_id], params[:apply_vacancy_id], @proposal), flash: {notice: 'Proposta Enviada'}
    else
      # TODO: deixar o erro dinâmico
      redirect_to vacancy_path(params[:vacancy_id]), flash: {notice: 'Campo(s) não pode ficar em branco'}
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:start_date, :salary,
                                     :benefits, :job_functions,
                                     :vacancy_id, :apply_vacancy_id )
  end
end