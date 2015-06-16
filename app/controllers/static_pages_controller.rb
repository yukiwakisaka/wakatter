class StaticPagesController < ApplicationController

  before_action :destroy_aka, only: :gameover

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

  def explanation
    render :layout => "second_layout"
  end

  def about
    render :layout => "second_layout"
  end

  def contact
    render :layout => "second_layout"
  end  

  def gameover
    render :layout => "go_layout"
  end

  private 
    def destroy_aka
      if signed_in?
        current_user.destroy unless current_user.admin
      end
    end

end
