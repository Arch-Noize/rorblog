class Api::V1::UsersController < ApplicationController
    def index
        @user = User.find(params[:api_user_id])
        @posts = @user.posts
        render json: @posts
      end
end
