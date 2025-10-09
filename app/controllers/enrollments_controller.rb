class EnrollmentsController < ApplicationController
  before_action :authorize_request

  # POST /courses/:course_id/enroll
  def create
    return render json: { error: "Only murid can enroll" }, status: :forbidden unless @current_user.role == "murid"

    course = Course.find(params[:course_id])
    existing = @current_user.enrollments.find_by(course: course)
    return render json: { message: "Already enrolled" }, status: :ok if existing

    enrollment = @current_user.enrollments.build(course: course)
    if enrollment.save
      render json: {
        message: "Enrollment successful",
        enrollment: enrollment.as_json(include: { course: { only: [:id, :title] } })
      }, status: :created
    else
      render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /courses/:course_id/enroll
  def destroy
    enrollment = @current_user.enrollments.find_by(course_id: params[:course_id])
    return render json: { error: "Enrollment not found" }, status: :not_found unless enrollment

    enrollment.destroy
    head :no_content
  end

  # GET /enrollments
  def index
    enrollments = @current_user.enrollments.includes(:course)
    render json: enrollments.as_json(include: { course: { only: [:id, :title, :description] } })
  end
end
