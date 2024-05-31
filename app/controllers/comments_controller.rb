class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.prototype_id = params[:prototype_id]
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      # エラーハンドリング: コメントが保存できない場合
      flash[:alert] = "コメントの保存に失敗しました。"
      redirect_to prototype_path(@comment.prototype)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
