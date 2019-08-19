class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(24)
  end

  def show
    @user = User.find_by!(username: params[:username])

    @posts = @user.posts.page(params[:page]).per(24)
    @following = @user.following.page(params[:page]).per(24)
    @followers = @user.followers.page(params[:page]).per(24)
  end
end