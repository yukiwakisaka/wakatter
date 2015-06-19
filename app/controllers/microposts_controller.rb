class MicropostsController < ApplicationController

  include WakaruHelper
  
  before_action :signed_in_user
  before_action :correct_user, only: :destroy
  before_action :request_from, only: :show

  def show
    if present_post(params[:id])
      @micropost = Micropost.find(params[:id])
      @waka = WakaruRelation.where(wakarareru_post: @micropost).pluck(:wakaru_user_id)
      @users = User.where(id: @waka)
    else
      undefined_url
    end
  end

  def create
  	@micropost = current_user.microposts.build(micropost_params)
  	if @micropost.save
  		flash[:success] = 'やったね、つぶやけたね。'
  		redirect_to root_url
  	else
  		@feed_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private
  	def micropost_params
  		params.require(:micropost).permit(:content)
  	end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end