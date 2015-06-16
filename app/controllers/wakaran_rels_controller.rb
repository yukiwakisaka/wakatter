class WakaranRelsController < ApplicationController

  include WakaruHelper

  before_action :signed_in_user
  before_filter :request_from
  after_action :akaban, only: :create 

  def create
    if present_post(params[:wakaran_rel][:wakararen_post_id])
      @wakararen = Micropost.find(params[:wakaran_rel][:wakararen_post_id])
      current_user.wakaran!(@wakararen)
    end
    redirect_back
  end

  def destroy
    if present_post(params[:id])
      @wakararen = WakaranRel.find(params[:id]).wakararen_post
      current_user.unwakaran!(@wakararen)
    end
    redirect_back
  end
end