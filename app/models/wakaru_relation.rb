class WakaruRelation < ActiveRecord::Base
	
	belongs_to :wakaru_user, class_name: "User"
	belongs_to :wakarareru_post, class_name: "Micropost"

	validates :wakaru_user_id, presence: true
	validates :wakarareru_post_id, presence: true
end
