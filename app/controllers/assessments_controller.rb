class AssessmentsController < ApplicationController
  before_action :authorize_request

  def create
    return render json: { error: "Only guru can create assessments" }, status: :forbidden unless @current_user.role == "guru"

    assessment = Assessment.new(assessment_params)
    if assessment.save
      render json: assessment, status: :created
    else
      render json: { errors: assessment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def assessment_params
    params.permit(:lesson_id, :title, :description)
  end
end