class WakaranRel < ActiveRecord::Base
	
	belongs_to :wakaran_user, class_name: "User"
	belongs_to :wakararen_post, class_name: "Micropost"

	validates :wakaran_user_id, presence: true
	validates :wakararen_post_id, presence: true
end
