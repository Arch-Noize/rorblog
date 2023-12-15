class Api::V1::CommentsController < ApplicationController

  def index
    @comments = current_user.comments
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :text, :post_id)
  end
end
