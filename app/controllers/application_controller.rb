class ApplicationController < ActionController::Base

  private

  def authorized_candidate
    unless candidate_signed_in?
      flash[:notice] = 'Acesso Negado!'
      redirect_to root_path
    end
  end
  
  def profile_presence?
    if candidate_signed_in?
      if current_candidate.profile.blank? 
        flash[:notice] = 'Precisa Completar o perfil!'
        redirect_to new_profile_path
      end
    end
  end

  def authorized_headhunter
    unless headhunter_signed_in?
      flash[:notice] = 'Acesso Negado!'
      redirect_to root_path
    end
  end
end
