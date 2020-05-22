class CandidatesPagesController < ApplicationController
  def index
    id = current_candidate
    @candidate = current_candidate

    unless @candidate.profile.present?
      # redirect_to candidates_page_profiles_path(id)
      # redirect_to new_profile_path(@candidate)
      redirect_to new_profile_path
    end

  end







end