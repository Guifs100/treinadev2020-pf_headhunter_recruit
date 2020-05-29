class RejectApplyVacanciesController < ApplicationController
  before_action :authorized_headhunter

  def new
    @vacancy = Vacancy.find(params[:vacancy_id])
    @apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
    @reject_apply_vacancy = RejectApplyVacancy.new
  end

  def create
    @reject_apply_vacancy = RejectApplyVacancy.new(reject_apply_vacancy_params)
    @reject_apply_vacancy.apply_vacancy = ApplyVacancy.find(params[:apply_vacancy_id])
    @reject_apply_vacancy.headhunter = current_headhunter
    if @reject_apply_vacancy.save
      redirect_to vacancy_path(params[:vacancy_id]), flash: {notice: 'Perfil Rejeitado'}
    else
      # TODO: deixar o erro dinâmico
      redirect_to vacancy_path(params[:vacancy_id]), flash: {notice: 'Feedback não pode ficar em branco'}
    end
  end

  private

  def reject_apply_vacancy_params
    params.require(:reject_apply_vacancy).permit(:feedback, :vacancy_id,
                                                 :apply_vacancy_id )
  end
end