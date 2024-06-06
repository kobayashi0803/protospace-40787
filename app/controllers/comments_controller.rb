class CommentsController < ApplicationController
before_action :set_prototype

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.prototype_id = params[:prototype_id]
    if @comment.save
      redirect_to prototype_path(@comment.prototype), notice: 'Comment was successfully created.'
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
