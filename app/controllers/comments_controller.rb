class CommentsController < ApplicationController
 before_action :authorized_headhunter 
  def new
    @comment = Comment.new
    @profile = Profile.find(params[:profile_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.headhunter = current_headhunter
    @comment.profile = Profile.find(params[:profile_id])
    if @comment.save
      flash[:notice] = 'Comentário Criado!'
      redirect_to profile_path(@comment.profile)
    else
      redirect_to new_profile_comment_path(@comment.profile.id), flash: {notice: 'Comentário não pode ficar em branco!'}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end