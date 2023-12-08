class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id]).order(id: :asc)
    @posts = @posts.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
end
