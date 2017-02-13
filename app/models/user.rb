class User < ActiveRecord::Base
	# validates :email, :handle, uniqueness: true
	# validates :name, :email, :password, :handle, presence: true

	# validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
	# 							message: 'Invalid Email!' }
	# validates :password, length: { within: 6..40,
	# 								message: 'Password should consist of 6-40 characters' }
end
