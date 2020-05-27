class CandidatesHomeController < ApplicationController
  before_action :profile_presence

  def index
    @candidate = current_candidate
    # @vacancies = Vacancy.where(status: :available)'
    @vacancies = Vacancy.where("status = ? ", Vacancy.statuses[:available])

    unless @candidate.profile.present?
      redirect_to new_profile_path
    end



  end

  private
  
  def profile_presence
    unless current_candidate.profile.present?
      flash[:notice] = 'Precisa Completar o perfil!'
      redirect_to new_profile_path
    end
  end

end