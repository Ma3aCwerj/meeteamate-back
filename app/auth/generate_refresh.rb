##
#
class GenerateRefresh
  def self.token(payload)
    payload[:exp] = 30.days.from_now.to_i
    payload[:iat] = Time.now.to_i
    payload[:sub] = 'refrsh_token'
    JsonWebToken.encode(payload)    
  end
end
