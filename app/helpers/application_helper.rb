module ApplicationHelper

	#ページごとの完全なタイトルを返します
	def full_title(page_title)
		base_title = "わかったー"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	# def destroy_wakararenai_user(micropost)
	# 	user = micropost.user
		

	# end

end
