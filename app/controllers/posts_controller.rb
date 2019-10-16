class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search]
  before_action :correct_user,       only: [:edit, :update, :destroy]

  def show
    @post = Post.find_by!(url_token: params[:url_token])
    @post_likes = @post.like_users.page(params[:page]).per(24)
    @comments = @post.comments.page(params[:page]).per(24)

    @comment = @post.comments.build
  end

  def new
    @post = current_user.posts.build if user_signed_in?
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = "投稿が送信されました"
      redirect_to user_path(current_user)
    else
      render 'posts/new'
    end
  end

  def edit
    @post = Post.find_by!(url_token: params[:url_token])
  end

  def update
    @post = Post.find_by!(url_token: params[:url_token])
    if @post.update_attributes(post_params)
      flash[:success] = "投稿が更新されました"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find_by!(url_token: params[:url_token]).destroy
    flash[:success] = "投稿は正常に削除されました"
    redirect_to current_user
  end

  def search
    
  end

  private

  def post_params
    params.require(:post).permit(:image, :image_cache, :caption, :user_id)
  end

  def correct_user
    @post = Post.find_by!(url_token: params[:url_token])
    redirect_to(root_url) unless @post.user == current_user
  end
end
