class WakaranRelsController < ApplicationController

  before_action :signed_in_user
  before_filter :request_from
  after_action :akaban, only: :create 

  def create
    if present_post(params[:wakaran_rel][:wakararen_post_id])
      @wakararen = Micropost.find(params[:wakaran_rel][:wakararen_post_id])
      current_user.wakaran!(@wakararen)
    end
    respond_to do |format|
        format.html { redirect_back }
        format.js
    end
  end

  def destroy
    if present_post(params[:id])
      @wakararen = WakaranRel.find(params[:id]).wakararen_post
      current_user.unwakaran!(@wakararen)
    end
    respond_to do |format|
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