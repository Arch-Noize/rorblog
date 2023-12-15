class PostsController < ApplicationController
  before_action :set_user, only: %i[index new create]

  def index
    @posts = @user.posts.includes(:comments).build
    @posts = @user.posts.includes(:comments).paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error, the post cannot be created!'
      render :new
    end
  end

  def destroy
    @post = Post.includes(:likes).find(params[:id])
    Comment.where(post_id: @post.id).destroy_all
    @author = @post.author
    @author.decrement!(:post_counter)
    @post.likes.destroy_all
    @post.destroy

    redirect_to user_posts_path(id: @author.id), notice: 'Post successfully deleted'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
