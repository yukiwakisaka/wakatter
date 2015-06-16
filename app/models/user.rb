class User < ActiveRecord::Base

	has_many :microposts, dependent: :destroy

	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	has_many :wakaru_relations, foreign_key: "wakaru_user_id", dependent: :destroy
	has_many :wakarareru_posts, through: :wakaru_relations, source: :wakarareru_post

	has_many :wakaran_rels, foreign_key: "wakaran_user_id", dependent: :destroy
	has_many :wakararen_posts, through: :wakaran_rels, source: :wakararen_post

	has_secure_password
	before_save{email.downcase!}
	before_create :create_remember_token

	validates :name, presence: true, length:{maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
			format:{with: VALID_EMAIL_REGEX}, 
			uniqueness: {case_sensitive: false}
	validates :password, length: {minimum: 6}

	def User.new_remember_token
  		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
  		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		Micropost.from_users_followed_by(self)
	end

	# フォロー
	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end

	# わかる
	def wakaru?(wakarareru)
		wakaru_relations.find_by(wakarareru_post_id: wakarareru.id)
	end

	def wakaru!(wakarareru)
		wakaru_relations.create!(wakarareru_post_id: wakarareru.id)
	end

	def wakaranai!(wakarareru)
		wakaru_relations.find_by(wakarareru_post_id: wakarareru.id).destroy
	end	

	# わからん
	def wakaran?(wakararen)
		wakaran_rels.find_by(wakararen_post_id: wakararen.id)
	end

	def wakaran!(wakararen)
		wakaran_rels.create!(wakararen_post_id: wakararen.id)
	end

	def unwakaran!(wakararen)
		wakaran_rels.find_by(wakararen_post_id: wakararen.id).destroy
	end

	private
	    def create_remember_token
	      self.remember_token = User.encrypt(User.new_remember_token)
	    end
end
