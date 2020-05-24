class CandidatesHomeController < ApplicationController
  def index
    @candidate = current_candidate
    # @vacancies = Vacancy.where(status: :available)'
    @vacancies = Vacancy.where("status = ? ", Vacancy.statuses[:available])

    unless @candidate.profile.present?
      redirect_to new_profile_path
    end



  end


end