class Api::V1::CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index create]
  skip_before_action :verify_authenticity_token

  def index
    post = Post.find(params[:post_id])
    @comments = post.comments
    render json: @comments
  end

  def create
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    @comment.author = user

    if @comment.save
      render json: 'Comment saved successfully!'
    else
      render json: { error: 'Error creating comment', details: @comment.errors.full_messages }
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
