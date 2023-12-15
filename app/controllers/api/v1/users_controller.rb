class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @user = User.find(params[:id])
    @posts = @user.posts
    render json: @posts
  end
end
