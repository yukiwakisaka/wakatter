class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    if present_user(params[:relationship][:followed_id])
      @user = User.find(params[:relationship][:followed_id])
      current_user.follow!(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if present_user(params[:id])
      @user = Relationship.find(params[:id]).followed
      current_user.unfollow!(@user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      redirect_to root_path
    end
  end
end