class UsersController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      jwt = Auth.encode(user_id: user.id)
      render json: { auth_token: jwt }
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def index
    render json: User.all
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
