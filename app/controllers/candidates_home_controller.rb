class CandidatesHomeController < ApplicationController
  before_action :profile_presence?
  before_action :authorized_candidate

  def index
    @vacancies = Vacancy.index_candidate(current_candidate.profile)
  end

end