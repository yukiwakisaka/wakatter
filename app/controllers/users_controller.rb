class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

	def show
    if present_user(params[:id])
  		@user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
    elsif signed_in?
      redirect_to gameover_path
    else
      redirect_to root_path
    end
	end

  def new
  	@user = User.new
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "へんこーできたよ（はあと"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create 
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
    	flash[:success] = "おめでとう、これで君もわかられるさんだ！"
      redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def destroy
    unless User.find(params[:id]).admin
      User.find(params[:id]).destroy
      flash[:success] = "ほな、ばいなら。"
      redirect_to users_url
    end
  end

  def following
    @title = "ほろー"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "ほろわー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private 

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    #Before actions

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
