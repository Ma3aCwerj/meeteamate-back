##
#
class RefreshToken
  prepend SimpleCommand
  attr_accessor :token
  
  def initialize(token)
    @token = token
  end
    
  def call
    payload = {user_id: user.id}
     { access_token: JsonWebToken.encode(payload, 2.minutes.from_now),
      refresh_token: JsonWebToken.encode(payload, 5.minutes.from_now),} if user
  end

  private
  
  def user
    user = @current_user
    
    # user = User.find_by_email(email)
    # return user if user && user.authenticate(password)
    # errors.add :user_authentication, 'Invalid credentials'
  end
end
