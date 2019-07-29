class PostsController < ApplicationController

  def show
    @post = Post.find_by!(id: params[:id])
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
    @post = Post.find_by!(id: params[:id])
  end

  def update
    @post = Post.find_by!(id: params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "投稿が更新されました"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find_by!(id: params[:id]).destroy
    flash[:success] = "投稿は正常に削除されました"
    redirect_to current_user
  end

  private

  def post_params
    params.require(:post).permit(:image, :image_cache, :caption, :user_id)
  end
end
