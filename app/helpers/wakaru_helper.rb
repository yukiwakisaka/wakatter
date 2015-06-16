module WakaruHelper

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