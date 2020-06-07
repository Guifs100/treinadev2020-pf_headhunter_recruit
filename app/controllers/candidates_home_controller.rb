class CandidatesHomeController < ApplicationController
  before_action :profile_presence?
  before_action :authorized_candidate

  def index
    @candidate = current_candidate

    @vacancies = Vacancy.index_candidate(current_candidate.profile)
  end

end