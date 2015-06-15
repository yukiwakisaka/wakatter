module UsersHelper

	def gravatar_for(user, options = {size:100})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	    size = options[:size]
	    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	    image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	def icon_size(item)
		size_post = 10 + Math.log(Math.sqrt(item.user.microposts.count)) * 5
		if size_post > 50
			size_post = 50
		end
		
		size_wakaru =  item.wakaru_users.count * 5
		if size_wakaru > 50
			size_wakaru = 50
		end

		size_ff = (item.user.followers.count + item.user.followed_users.count) * 0.2
		if size_ff > 20
			size_ff = 20 
		end

		size = size_post + size_wakaru + size_ff
		return size
	end

	def wakaru_count(user)
		k = 0
		user.microposts.each do |p|
			k += p.wakaru_users.count
		end
		return k
	end

	def wakaran_count(user)
		k = 0
		user.microposts.each do |p|
			k += p.wakaran_users.count
		end
		return k
	end
end
