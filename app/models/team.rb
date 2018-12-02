class Team < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  has_many :member, dependent: :destroy  
end
