class StaticPagesController < ApplicationController

  def home
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
    else
      render :layout => "second_layout"
  	end
  end

  def help
    render :layout => "second_layout"
  end

  def about
    render :layout => "second_layout"
  end

  def contact
    render :layout => "second_layout"
  end
end
