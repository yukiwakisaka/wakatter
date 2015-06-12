module UsersHelper

	def gravatar_for(user, options = {size:100})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	    size = options[:size]
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	    image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def icon_size(post_count, wakaru_count)
		size = 10 + Math.log(Math.sqrt(post_count)) * 20
		if size > 40
			size = 40
		end
		size = size + wakaru_count * 1
		if size > 70
			size = 70
		end
		return size
	end
end
