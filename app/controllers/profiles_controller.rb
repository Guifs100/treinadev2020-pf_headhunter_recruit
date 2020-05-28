class ProfilesController < ApplicationController
  before_action :authorized_candidate, only: %i[new create edit update all_apply_jobs]
  before_action :profile_presence, only: %i[show edit all_apply_jobs]

  def show
    id = params[:id]
    @profile = Profile.find(id)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.candidate = current_candidate
    if @profile.save
      flash[:notice] = 'Perfil criada com sucesso'
      redirect_to @profile
    else
      render new_profile_path
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = 'Perfil Alterado'
      redirect_to @profile
    else
      render :new
    end
  end

  def all_apply_jobs
    @profile = Profile.find(current_candidate.profile.id)
    @apply_vacancies = ApplyVacancy.where('profile_id = ?', @profile.id)
  end

  private

  def profile_params
    params.require(:profile).permit(:photo, :full_name, :social_name,
                                    :birth_date, :formation,
                                    :description, :experience)
  end

  def profile_presence
    # unless current_candidate.profile.present? && headhunter_signed_in?
    unless current_candidate.profile.present? 
      flash[:notice] = 'Precisa Completar o perfil!'
      redirect_to new_profile_path
    end
  end
end