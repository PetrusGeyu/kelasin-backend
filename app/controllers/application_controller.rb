class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header.present?

    decoded = jwt_decode(header)
    if decoded && decoded[:user_id]
      @current_user = User.find_by(id: decoded[:user_id])
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    else
      render json: { error: 'Invalid or missing token' }, status: :unauthorized
    end
  end
end
