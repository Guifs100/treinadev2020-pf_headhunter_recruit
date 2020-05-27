class ApplicationController < ActionController::Base

  private

  def authorized_candidate
    unless candidate_signed_in?
      flash[:notice] = 'Acesso Negado!'
      redirect_to root_path
    end
  end

  def authorized_headhunter
    unless headhunter_signed_in?
      flash[:notice] = 'Acesso Negado!'
      redirect_to root_path
    end
  end
end
