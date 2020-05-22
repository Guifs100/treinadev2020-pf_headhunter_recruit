class ProfilesController < ApplicationController

  def show
    id = params[:id]
    @profile = Profile.find(id)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.candidate = current_candidate
    if @profile.save
      flash[:notice] = 'Perfil criada com sucesso'
      redirect_to @profile
    else
      render new_profile_path
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:photo, :full_name, :social_name,
                                    :birth_date, :formation,
                                    :description, :experience)
  end

end