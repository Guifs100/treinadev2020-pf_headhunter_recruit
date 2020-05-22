class CandidatesPagesController < ApplicationController
  def index
    # id = params[:id]
    id = current_candidate
    @candidate = current_candidate
    # @candidate = Candidate.find(id)
    # @candidate = Candidate.find(params[:candidate_id])

    unless @candidate.profile.present?
      redirect_to candidates_page_profiles_path(id)
    end

  end







end