class User < ActiveRecord::Base
	# validates :email, :handle, uniqueness: true
	# validates :name, :email, :password, :handle, presence: true

	# validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
	# 							message: 'Invalid Email!' }
	# validates :password, length: { within: 6..40,
	# 								message: 'Password should consist of 6-40 characters' }

	has_many :tweets
	has_many :likes
	has_many :follower_mappings, class_name: 'FollowMapping', foreign_key: 'followee_id'
	has_many :followee_mappings, class_name: 'FollowMapping', foreign_key: 'follower_id'
	has_many :followers, through: :follower_mappings
	has_many :followees, through: :followee_mappings


	def feed 
		# To see tweets of followees only
		users = followees.pluck(:id) + [self.id]
		feed_tweets = Tweet.includes(:user, :likes).where("user_id in (?)", users)
		feed_tweets # return
	end


end
