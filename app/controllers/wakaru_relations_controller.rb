class WakaruRelationsController < ApplicationController
  before_action :signed_in_user

  def create
    @wakarareru = Micropost.find(params[:wakaru_relation][:wakarareru_post_id])
    logger.debug "------------------------------VVV----------------------------------"
    logger.debug wakarareru_post_id
    current_user.wakaru!(@wakarareru)
    # redirect_to root_path
    respond_to do |format|
        format.html { redirect_to root_path }
        format.js
    end
  end

  def destroy
    # @wakarareru = WakaruRelation.find(params[:id]).wakarareru_post
    # current_user.wakaranai!(@wakarareru)
    # redirect_to root_path
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end