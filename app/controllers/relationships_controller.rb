class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user) unless current_user.following.include?(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    if relationship.nil?
      @user = User.find(params[:user_id])
    else
      @user = relationship.followed
      current_user.unfollow(@user)
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
