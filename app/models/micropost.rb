class Micropost < ActiveRecord::Base
  has_many :reverse_wakaru_relations, foreign_key: "wakarareru_post_id", class_name: "WakaruRelation", dependent: :destroy
  has_many :wakaru_users, through: :reverse_wakaru_relations, source: :wakaru_user

  has_many :reverse_wakaran_rels, foreign_key: "wakararen_post_id", class_name: "WakaranRel", dependent: :destroy
  has_many :wakaran_users, through: :reverse_wakaran_rels, source: :wakaran_user

	belongs_to :user
	default_scope -> { order('created_at DESC') }
  	validates :user_id, presence: true
  	validates :content, presence: true, length: {maximum: 140}

  	def self.from_users_followed_by(user)
  		followed_user_ids = "SELECT followed_id FROM relationships
  								WHERE follower_id = :user_id"
  		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  	end
end
