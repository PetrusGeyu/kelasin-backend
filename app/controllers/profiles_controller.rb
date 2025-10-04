class ProfilesController < ApplicationController
  # GET /me
  def show
    render json: {
      id: @current_user.id,
      name: @current_user.name,
      email: @current_user.email,
      role: @current_user.role,
      profile: @current_user.profile
    }, status: :ok
  end
end
