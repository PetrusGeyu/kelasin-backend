class EnrollmentsController < ApplicationController
  before_action :authorize_request

  def create
    return render json: { error: "Only murid can enroll" }, status: :forbidden unless @current_user.role == "murid"

    enrollment = @current_user.enrollments.build(course_id: params[:course_id])
    if enrollment.save
      render json: enrollment, status: :created
    else
      render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    enrollments = @current_user.enrollments.includes(:course)
    render json: enrollments.to_json(include: :course)
  end
end