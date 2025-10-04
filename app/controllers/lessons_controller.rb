class LessonsController < ApplicationController
  before_action :authorize_request
  before_action :set_course

  def index
    lessons = @course.lessons
    render json: lessons
  end

  def create
    return render json: { error: "Only guru can create lessons" }, status: :forbidden unless @current_user.role == "guru"

    lesson = @course.lessons.build(lesson_params)
    if lesson.save
      render json: lesson, status: :created
    else
      render json: { errors: lesson.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.permit(:title, :content)
  end
end