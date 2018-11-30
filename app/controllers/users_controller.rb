##
#
class UsersController < ApplicationController
	require 'user_agent_parser'
  skip_before_action :authenticate_request, only: %i[login register authenticate]
	
	def register
		user = User.new(user_params)
		if user.save 
			login
		else
			render json: user.errors, status: :bad_request
		end
	end

	def login
    authenticate params[:email], params[:password]
  end

  def refresh
  	token = Token.find_by(token: headers['Authorization'].split(' ').last)
  	return render json: refresh_tokens(current_user, token) if token	
		render json: {message: 'Invalid token'}, status: :unauthorized
	end

  def index
    cnt = User.count
    users = User.users_to_view.page(params[:page]).per(params[:limit])
    if users      
      render json: {count: cnt, users:  users}, status: :ok
    else
      render json: {message: 'Not found'}, status: :bad_request
    end
  end

  def show
    user = User.users_to_view.find(params[:id])
    render json: user, status: :ok
    rescue
      render json: {message: 'Not found'}, status: :bad_request
  end

  def update    
    user = User.find(params[:id])    
    if user.id == current_user.id
      user.update(user_params)
      if user.save
        show
      else
        render json: {message: 'Not save'}, status: :unprocessable_entity
      end
    else
      render json: {message: 'Unprocessable entity'}, status: :unprocessable_entity
    end  
    rescue
      render json: {message: 'Not found'}, status: :bad_request
  end

  private

  def authenticate(email, password)
  	user = get_user(email, password)
  	return render json: generate_tokens(user) if user
 		render json: {message: 'Invalid credentials'} , status: :unauthorized
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
    params.permit(:email, :password, :username, :page, :fullname, :about, :city, :birthday, :picture, :limit)
  end
end
