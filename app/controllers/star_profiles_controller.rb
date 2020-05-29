class StarProfilesController < ApplicationController
  before_action :authorized_headhunter

  def create
    @star_profile = StarProfile.new
    @star_profile.headhunter = current_headhunter
    @star_profile.profile = Profile.find(params[:profile_id])
    @star_profile.save
    redirect_to profile_path(@star_profile.profile.id), flash: {notice: 'Perfil Favoritado com sucesso'}
  end

  def destroy
    @star_profile = StarProfile.search(params[:profile_id], current_headhunter.id)
    @star_profile.destroy
    redirect_to profile_path(params[:profile_id]), flash: {notice: 'Perfil Desfavoritado com sucesso'}
  end

  private

  def star_profile_params
    params.require(:star_profile).permit(:profile_id)
  end
end