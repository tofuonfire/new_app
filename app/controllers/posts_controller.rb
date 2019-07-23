class PostsController < ApplicationController

  def new
    @post = current_user.posts.build if user_signed_in?
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = "投稿が送信されました"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :image_cache, :caption)
  end
end
