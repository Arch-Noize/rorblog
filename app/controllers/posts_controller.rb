class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id]).order(id: :asc)
    @posts = @posts.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:sucess] = 'Post created successfuly!'
      redirect_to user_posts_url
    else
      flash.now[:error] = 'Error, the post cannot be created!'
      render :new, locals: { post: @post }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
