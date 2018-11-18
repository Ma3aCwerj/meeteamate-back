##
#
class User < ApplicationRecord
	mount_uploader :picture, PictureUploader
	validates_presence_of :email, :password_digest, :username
	validates  :email , uniqueness: true

  has_secure_password

  has_many :token
  scope :users_to_view, -> {all.select(:id,:email, :username,:fullname,:picture,:about,:city,:birthday)}
end
