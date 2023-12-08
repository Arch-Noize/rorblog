class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = 'Comment created successfully!'
      redirect_to user_post_path(id: @comment.post_id, user_id: current_user.id)
    else
      flash.now[:error] = 'Error, the comment cannot be created!'
      render :new, locals: { comment: @comment }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
