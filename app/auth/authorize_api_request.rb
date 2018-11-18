##
#
class AuthorizeApiRequest
  attr_reader :headers
  prepend SimpleCommand
  
  def initialize(headers = {})
    @headers = headers
  end
  
  def call
    user
  end
  
  private  
  
  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end
  
  def decoded_auth_token
    token = http_auth_header
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header) if token
  end
  
  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
  end
end
