class ApplicationController < ActionController::API
  before_action :authenticate_request!

  protected

  def authenticate_request!
    if !payload || !Auth.valid_payload(payload)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  def invalid_authentication
    render json: { error: 'Invalid Request' }, status: :unauthorized
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    Auth.decode(token)
  rescue
    nil
  end

  def load_current_user!
    @current_user = User.find(payload['user_id'])
  end
end
