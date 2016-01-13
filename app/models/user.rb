class User < ActiveRecord::Base
	has_many :photos_users
	has_many :photos, :through => :photos_users

	validates_length_of :username, within: 1..20, too_long: 'pick a shorter name', too_short: 'pick a longer name'
	validates :username, :presence => {:message => 'Name cannot be blank'}
	validates :username, uniqueness: { case_sensitive: false }
end
