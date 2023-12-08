class PostsController < ApplicationController
  before_action :set_user, only: %i[index new create]

  def index
    @posts = @user.posts.build
    @posts = @user.posts.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    Rails.logger.debug "POST PARAMS: #{post_params.inspect}"
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error, the post cannot be created!'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
