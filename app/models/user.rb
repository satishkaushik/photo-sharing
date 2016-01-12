class User < ActiveRecord::Base
	has_many :photos_users
	has_many :photos, :through => :photos_users

	validates_length_of :username, within: 6..20, too_long: 'pick a shorter name', too_short: 'pick a longer name'
	validates :username, :presence => {:message => 'Name cannot be blank'}
	#validates_presence_of :username, :message: "You can not leave this field blank"
end
