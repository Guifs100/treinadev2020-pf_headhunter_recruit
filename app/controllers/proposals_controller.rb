class ProposalsController < ApplicationController
  before_action :authorized_headhunter, only: %i[new create]
  before_action :authorized_candidate, only: %i[edit update reject_other_proposals]

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
      @proposal.initial!
      redirect_to vacancy_apply_vacancy_proposal_path(params[:vacancy_id], params[:apply_vacancy_id], @proposal), flash: {notice: 'Proposta Enviada'}
    else
      # TODO: deixar o erro dinâmico
      redirect_to vacancy_path(params[:vacancy_id]), flash: {notice: 'Campo(s) não pode ficar em branco'}
    end
  end

  def edit
    @vacancy = Vacancy.find(params[:vacancy_id])
    @apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
    @proposal = Proposal.find(params[:id])
  end

  def update
    @vacancy = Vacancy.find(params[:vacancy_id])
    @apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
    @proposal = Proposal.find(params[:id])
    @proposal.status = params[:proposal][:status]
    if @proposal.initial?
      redirect_to edit_vacancy_apply_vacancy_proposal_path(@vacancy.id, @apply_vacancy.id, @proposal.id), flash: {notice: 'Precisa escolher uma resposta'}
    else
      if @proposal.update(proposal_params)
        if @proposal.accepted?
          reject_other_proposals
        end
        redirect_to all_proposals_profiles_path, flash: {notice: 'Resposta Enviada ao Headhunter'}
      else
        redirect_to edit_vacancy_apply_vacancy_proposal_path(@vacancy.id, @apply_vacancy.id, @proposal.id), flash: {notice: 'Precisa escolher uma resposta'}
      end
     
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:start_date, :salary,
                                     :benefits, :job_functions,
                                     :vacancy_id, :apply_vacancy_id,
                                     :status, :answer )
  end

  def reject_other_proposals
    @proposals = Proposal.reject_proposals(current_candidate.profile)
    # byebug
    @proposals.each do |proposal|
      proposal.answer = 'Aceitei outra oportunidade. Obrigado pela proposta'
      proposal.rejected!
    end
  end
end