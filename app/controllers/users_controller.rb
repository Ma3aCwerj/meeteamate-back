##
#
class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: %i[login register]
	
	def register
		@user = User.new(user_params)
		if @user.save 
			render json: { messge: 'User created'}, status: :created
		else
			render json: @user.errors, status: :bad
		end
	end

	def login
    authenticate params[:email], params[:password]
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)
    
		if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

	private

	def user_params
    params.permit( :email, :password)
  end
end
