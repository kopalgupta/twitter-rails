class User < ActiveRecord::Base

	validates :name, :email, :password, :handle, presence: true
	validates :email, :handle, uniqueness: true

	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
								message: 'Invalid Email!' }
	validates :password, length: { within: 6..40,
									message: 'Password should consist of 6-40 characters' }

	has_many :tweets
	has_many :likes
	has_many :comments
	has_many :retweets
	has_many :follower_mappings, class_name: 'FollowMapping', foreign_key: 'followee_id'
	has_many :followee_mappings, class_name: 'FollowMapping', foreign_key: 'follower_id'
	has_many :followers, through: :follower_mappings
	has_many :followees, through: :followee_mappings


	def feed 
		# To see my tweets and tweets of followees only
		users = followees.pluck(:id) + [self.id]
		feed_tweets = Tweet.includes(:user, :likes, :comments).where("user_id in (?)", users).order(created_at: :desc)
		feed_tweets # return
	end

	def feed_retweet
		users = followees.pluck(:id) + [self.id]
		feed_retweets = Retweet.includes(:user).where("user_id in (?)", users).order(created_at: :desc)
		feed_retweets
	end

	def self.search(search)
		# for search form
		where("name LIKE ? OR handle LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
		# where("email LIKE ?", "%#{search}%")
		# where("name LIKE ?", "%#{search}%")
	end

end
