class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @posts = Post.where(author_id: params[:user_id])
    render json: @posts
  end
end
