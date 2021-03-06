class StaticPagesController < ApplicationController

  before_action :destroy_aka, only: :gameover
  before_action :apply_second_layout, only: [:help, :explanation, :about, :contact, :erotter]

  def home
    store_location
  	if signed_in?
  		@micropost = current_user.microposts.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
      if current_user.followed_users.count == 0
        @comment = "ほろーしなきゃ！" 
      else
        @comment = "わかりうる呟き"
      end
    else
      apply_second_layout
  	end
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

    def apply_second_layout
      render :layout => "second_layout"
    end
end
