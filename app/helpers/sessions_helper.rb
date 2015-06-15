module SessionsHelper
  include UsersHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
    	user == current_user
  	end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
    	redirect_to(session[:return_to] || default)
    	session.delete(:return_to)
  	end

  	def store_location
    	session[:return_to] = request.url
  	end

  	def present_user(user_id)
  		if User.find_by(id: user_id).nil?
  			flash[:error] = "そのゆーざは存在しないか消去されましたw"
  			return false
  		else
  			return true
  		end
  		# if User.find(params[:id]).nil?
  		# 	flash[:error] = "そのゆーざは存在しないか消去されましたw"
  		# 	redirect_to root_path
  		# end
  	end

  	def present_post(post_id)
  		if Micropost.find_by(id: post_id).nil?
  			flash[:error] = "その呟きは存在しないか消去されましたw"
  			return false
  		else
  			return true
  		end
  	end

    def akaban
      if akaban?(@wakararen.user)
        unless @wakararen.user.admin
          User.find_by(id: @wakararen.user.id).destroy
          flash[:error]="ban!!!!!!!"
        end
      end
    end

    def akaban?(user)
      wakaru_count(user)+3<wakaran_count(user)
    end
end