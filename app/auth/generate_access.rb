##
#
class GenerateAccess
  def self.token(payload)
  	# Временно для тестов выставлено 6 минут
    # payload[:exp] = 30.minutes.from_now.to_i
    payload[:exp] = 6.minutes.from_now.to_i
    payload[:iat] = Time.now.to_i
    payload[:sub] = 'access_token'
    JsonWebToken.encode(payload)
   end
end
