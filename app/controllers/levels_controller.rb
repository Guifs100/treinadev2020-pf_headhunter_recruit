class LevelsController < ApplicationController
  before_action :authorized_headhunter
  
  def new
    @level = Level.new
  end

  def create
    @level = Level.new(level_params)
    if @level.save
      flash[:notice] = 'Level Cadastrado com sucesso!'
      redirect_to root_path
    else
      render new_level_path
    end
  end

  private

  def level_params
    params.require(:level).permit(:name)
  end
end