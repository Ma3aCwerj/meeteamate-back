##
#
class UsersController < ApplicationController
	require 'user_agent_parser'
	skip_before_action :authenticate_request, only: %i[login register]
	
	def register
		@user = User.new(user_params)
		if @user.save 
			login
			# render json: { messge: 'User created'}, status: :created
		else
			render json: @user.errors, status: :bad
		end
	end

	def login
    authenticate params[:email], params[:password]
  end

  def refresh
  	@token = Token.find_by(token: headers['Authorization'].split(' ').last)
  	return render json: refresh_tokens(current_user, @token) if @token	
		render json: {message: 'Invalid token'}, status: :user_authentication  		
	end

  private

  def authenticate(email, password)
  	user = get_user(email, password)
  	return render json: generate_tokens(user) if user
 		render json: {message: 'Invalid credentials'}, status: :user_authentication
  end

  def generate_tokens(user)
  	refresh = GenerateRefresh.token({user_id: user.id})
  	access = GenerateAccess.token({user_id: user.id})
  	@token = Token.new({user_agent: get_user_agent(request.user_agent), 
  				token: refresh, user_id: user.id})
  	return {access: access, refresh: refresh} if @token.save 
 		@token.errors
  end

  def refresh_tokens(user, token_old)
  	refresh = GenerateRefresh.token({user_id: user.id})
  	access = GenerateAccess.token({user_id: user.id})
  	@token = token_old
  	@token.update(token: refresh)
  	if @token.save 
  		{access: access, refresh: refresh} 	
  	else
  		@token.errors
  	end
  end

	def get_user_agent(user_agent)
		ua = UserAgentParser.parse user_agent
		{ brawser: ua.family, os: ua.os.to_s}
	end

	def get_user(email, password)
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)
  end

	def user_params
    params.permit( :email, :password, :username)
  end
end
