class StaticPagesController < ApplicationController
  def home
    @posts = Post.page(params[:page]).per(36)
  end

  def help
  end

  def about
  end

  def contact
  end
end
