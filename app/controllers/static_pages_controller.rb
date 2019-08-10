class StaticPagesController < ApplicationController
  def home
    @following_posts = Post.page(params[:page]).per(12)
    @latest_posts = Post.page(params[:page]).per(24)
  end

  def help
  end

  def about
  end

  def contact
  end
end
