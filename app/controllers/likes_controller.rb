class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)
    if @like.save
      flash[:success] = 'Liked!'
      redirect_to user_post_path(id: @like.post_id, user_id: @like.author_id)
    else
      flash.now[:error] = 'Something went wrong, please try again!'
    end
  end
end
