##
#
class User < ApplicationRecord
	mount_uploader :picture, PictureUploader
	validates_presence_of :email, :password_digest, :username
	validates  :email , uniqueness: true

  has_secure_password

  has_many :token

  has_many :team
  
  scope :users_to_view, -> {all.select(:id,:username,:fullname,:picture,:about,:city,:birthday)}
  scope :current_user_to_view, -> {all.select(:id,:email,:username,:fullname,:picture,:about,:city,:birthday)}
end
