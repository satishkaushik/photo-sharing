class Photo < ActiveRecord::Base
  has_many :photos_users
  has_many :users, :through => :photos_users

  validates :file_name, :presence => true

  accepts_nested_attributes_for :photos_users
end
