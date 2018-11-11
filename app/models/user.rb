##
#
class User < ApplicationRecord
	validates_presence_of :email, :password_digest, :username
	validates  :email , uniqueness: true

  has_secure_password

  has_many :token
end
