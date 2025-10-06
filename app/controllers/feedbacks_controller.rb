class FeedbacksController < ApplicationController
  before_action :authorize_request
  before_action :set_course

  def index
    feedbacks = @course.feedbacks.includes(:user)
    render json: feedbacks.as_json(
      only: [:id, :content, :created_at],
      include: {
        user: { only: [:id, :first_name, :last_name, :email, :role] }
      }
    )
  end

  def create
    feedback = @course.feedbacks.build(feedback_params.merge(user: @current_user))
    if feedback.save
      render json: feedback.as_json(
        only: [:id, :content, :created_at],
        include: {
          user: { only: [:id, :first_name, :last_name, :email, :role] }
        }
      ), status: :created
    else
      render json: { errors: feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def feedback_params
    params.permit(:content)
  end
end
