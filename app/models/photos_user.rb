class PhotosUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  accepts_nested_attributes_for :user
end
