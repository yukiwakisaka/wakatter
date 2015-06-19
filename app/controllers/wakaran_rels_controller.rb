class WakaranRelsController < ApplicationController

  include WakaruHelper

  before_action :signed_in_user
  before_filter :request_from

  def create
    if present_post(params[:wakaran_rel][:wakararen_post_id])
      @wakararen = Micropost.find(params[:wakaran_rel][:wakararen_post_id])
      current_user.wakaran!(@wakararen)
      akaban
    end
    redirect_to micropost_path(@wakararen)
  end

  def destroy
    if present_post(WakaranRel.find(params[:id]).wakararen_post.id)
      @wakararen = WakaranRel.find(params[:id]).wakararen_post
      current_user.unwakaran!(@wakararen)
    end
    redirect_back
  end
end