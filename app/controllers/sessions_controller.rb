class SessionsController < ApplicationController
  skip_before_action :authenticate_request!

  def create
    user = User.find_by(username: auth_params[:username])
    if user.authenticate(auth_params[:password])
      jwt = Auth.encode(user_id: user.id)
      render json: { auth_token: jwt }
    else
      render json: { error: 'Invalid username / password' }, status: 401
    end
  end

  private

    def auth_params
      params.require(:user).permit(:username, :password)
    end
end
