class ProfilesController < ApplicationController
  before_action :authorized_candidate, only: %i[new create edit update all_apply_jobs all_reject_applies]
  before_action :profile_presence?, only: %i[show edit all_apply_jobs all_reject_applies all_proposals]

  def show
    id = params[:id]
    @profile = Profile.find(id)
    @comments = search_comments_profile
    @star_profile = search_star_profile
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.candidate = current_candidate
    if @profile.save
      flash[:notice] = 'Perfil criada com sucesso'
      current_candidate.profile = @profile
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
    @apply_vacancies = ApplyVacancy.profile_applies(@profile.id)
  end

  def all_reject_applies
    @reject_apply_vacancies = RejectApplyVacancy.reject_applies
  end

  def all_proposals
    @proposals = Proposal.profile_proposals
  end

  private

  def profile_params
    params.require(:profile).permit(:photo, :full_name, :social_name,
                                    :birth_date, :formation,
                                    :description, :experience)
  end

  def search_comments_profile
    if headhunter_signed_in?
      @profile = Profile.find(params[:id])
      @comments = Comment.search_comments(@profile.id, current_headhunter.id)
    end
  end
  
  def search_star_profile
    if headhunter_signed_in?
      @profile = Profile.find(params[:id])
      @star_profile = StarProfile.search(@profile.id, current_headhunter.id)
    end
  end
end