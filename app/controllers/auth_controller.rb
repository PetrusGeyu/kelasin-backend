class AuthController < ApplicationController
  skip_before_action :authorize_request, only: [ :register, :login ]

  # POST /register
  def register
    user = User.new(user_params)
    if user.save
      token = jwt_encode(user_id: user.id)
      render json: {
        message: "User registered successfully",
        token: token,
       user: {
  id: user.id,
  name: user.name,
  email: user.email,
  role: user.role
}

      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: {
        message: "Login successful",
        token: token,
        user: {
  id: user.id,
  name: user.name,
  email: user.email,
  role: user.role
}

      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # GET /me
  def me
    render json: current_user.slice(:id, :name, :email, :role)
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :role)
  end
end
