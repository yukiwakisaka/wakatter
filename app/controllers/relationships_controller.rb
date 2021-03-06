class RelationshipsController < ApplicationController
  
  before_action :signed_in_user

  def create
    if present_user(params[:relationship][:followed_id])
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user)
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def destroy
    if present_user(params[:id])
      @user = Relationship.find(params[:id]).followed
      current_user.unfollow!(@user)
      redirect_to @user
    else
      redirect_to root_path
    end
  end
end