##
# lib/json_web_token.rb
class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
    
    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
      rescue
        nil
      # rescue JWT::ExpiredSignature, JWT::VerificationError => e
      #   raise ExceptionHandler::ExpiredSignature, e.message
      # rescue JWT::DecodeError, JWT::VerificationError => e
      #   raise ExceptionHandler::DecodeError, e.message
    end
  end
end