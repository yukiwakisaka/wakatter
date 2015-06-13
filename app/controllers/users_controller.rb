class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

	def show
    if @user = User.find_by(id: params[:id])
  		@user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
    elsif current_user.id == params[:id]
      redirect_to game_over_path
    else
      redirect_to root_path
    end
	end

  def new
  	@user = User.new
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create 
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
    	flash[:success] = "Welcome to Wakatter!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
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
