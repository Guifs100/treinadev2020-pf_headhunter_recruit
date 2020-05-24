class CandidatesPagesController < ApplicationController
  def index
    id = current_candidate
    @candidate = current_candidate
    @vacancies = Vacancy.where(status: :available)

    unless @candidate.profile.present?
      redirect_to new_profile_path
    end



  end


end