class WakaruRelationsController < ApplicationController

  include WakaruHelper

  before_action :signed_in_user
  before_filter :request_from

  def create
    if present_post(params[:wakaru_relation][:wakarareru_post_id])
      @wakarareru = Micropost.find(params[:wakaru_relation][:wakarareru_post_id])
      current_user.wakaru!(@wakarareru)
    end
    redirect_back
  end

  def destroy
    if present_post(params[:id])
      @wakarareru = WakaruRelation.find(params[:id]).wakarareru_post
      current_user.wakaranai!(@wakarareru)

      @wakararer = @wakarareru.user
      flash[:success] = @wakararer.name
    end
    redirect_back
  end
end