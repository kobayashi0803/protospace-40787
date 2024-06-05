class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.prototype_id = params[:prototype_id]
    if @comment.save
      redirect_to prototype_path(@comment.prototype), notice: 'Comment was successfully created.'
    else
      flash.now[:alert] = 'There was an error creating the comment.'
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
