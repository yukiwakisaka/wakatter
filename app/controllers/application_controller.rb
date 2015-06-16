class ApplicationController < ActionController::Base
  
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	
	include SessionsHelper
	
	# 例外処理
	protect_from_forgery with: :exception
	rescue_from ActiveRecord::RecordNotFound, with: :render_404
	rescue_from ActionController::RoutingError, with: :render_404
	rescue_from Exception, with: :render_500

	def render_404
		undefined_url
	end

	def render_500
		undefined_url
	end
end
