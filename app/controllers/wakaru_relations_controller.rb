class WakaruRelationsController < ApplicationController

  before_action :signed_in_user
  before_filter :request_from

  def create
    if present_post(params[:wakaru_relation][:wakarareru_post_id])
      @wakarareru = Micropost.find(params[:wakaru_relation][:wakarareru_post_id])
      # logger.debug "------------------------------VVV----------------------------------"
      current_user.wakaru!(@wakarareru)

      # @user = User.find_by(id: @wakarareru.user.id)
      # @user.update_attributes(wakaru_count: 10)
    end
    # logger.debug "done"
    # redirect_to root_path
    respond_to do |format|
        # format.html { redirect_to root_path }
        format.html { redirect_back }
        format.js
    end
    # logger.debug "complete"
  end

  def destroy
    if present_post(params[:id])
      @wakarareru = WakaruRelation.find(params[:id]).wakarareru_post
      current_user.wakaranai!(@wakarareru)

      @wakararer = @wakarareru.user
      flash[:success] = @wakararer.name
    end
    respond_to do |format|
      # format.html { redirect_to root_path }
      format.html { redirect_back }
      format.js
    end
  end


  private 

    def request_from
      if session[:request_from]
        @prev_page = session[:request_from]
      end
      session[:request_from] = request.original_url
    end

    def redirect_back
      if request.referer
        redirect_to( :back )
      elsif @prev_page
        redirect_to( @prev_page )
      else
        redirect_to("/")
      end
    end
end