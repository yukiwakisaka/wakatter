class SessionsController < ApplicationController

	def new
		redirect_to root_path if signed_in?
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or root_path
		else
			flash.now[:error] = '何か間違ってるか、垢バンされたかのいずれか。'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
