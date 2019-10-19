class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy

  def index
    @users = User.page(params[:page]).per(24)
  end

  def show
    @user = User.find_by!(username: params[:username])

    @posts = @user.posts.page(params[:page]).per(24)
    @following = @user.following.page(params[:page]).per(24)
    @followers = @user.followers.page(params[:page]).per(24)
    @likes = @user.like_posts.page(params[:page]).per(24)
  end

  def search
    @q = User.ransack(params[:q])
    @users =
      if params[:q].nil?
        @q.result(distinct: true).page(params[:page]).per(24)
      elsif params[:q][:username_cont].blank?
        User.none
      else
        @q.result(distinct: true).page(params[:page]).per(24)
      end
  end

  def destroy
    User.find_by!(username: params[:username]).destroy
    flash[:success] = "ユーザーは正常に削除されました"
    redirect_to users_url
  end

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end