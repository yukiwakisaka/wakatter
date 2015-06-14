class WakaranRelsController < ApplicationController
  before_action :signed_in_user
  before_filter :request_from

  def create
    @wakararen = Micropost.find(params[:wakaran_rel][:wakararen_post_id])
    # logger.debug "------------------------------VVV----------------------------------"
    current_user.wakaran!(@wakararen)
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
    @wakararen = WakaranRel.find(params[:id]).wakararen_post
    current_user.unwakaran!(@wakararen)
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