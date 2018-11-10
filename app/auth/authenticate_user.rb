##
#
class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password
  
  def initialize(email, password)
    @email = email
    @password = password
  end
    
  def call
    payload = {user_id: user.id}
     { access_token: JsonWebToken.encode(payload, 2.minutes.from_now),
      refresh_token: JsonWebToken.encode(payload, 5.minutes.from_now),} if user
  end

  private
  
  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)
    errors.add :user_authentication, 'Invalid credentials'
  end
end
