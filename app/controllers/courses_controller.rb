class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.all
    render json: @courses.as_json(only: [:id, :title, :description, :user_id])
  end

  # GET /mycourses
  def my_courses
    # Jika developer menggunakan role nama lain, sesuaikan ("guru"/"murid" vs "teacher"/"student")
    if current_user.role == "guru"
      courses = current_user.courses.includes(:lessons, :enrollments)
      source = "owned"
    else
      courses = current_user.enrolled_courses.includes(:lessons, :enrollments)
      source = "enrolled"
    end

    render json: {
      user: {
        id: current_user.id,
        name: full_name(current_user)
      },
      source: source,
      courses: courses.map { |c|
        {
          id: c.id,
          title: c.title,
          description: c.description,
          teacher_id: c.user_id,
          teacher_name: full_name(c.user),
          lessons_count: c.lessons.size,
          lessons: c.lessons.map { |l| { id: l.id, title: l.title } },
          students_count: c.enrollments.size
        }
      }
    }
  end

  # other actions: show, create, update, destroy (keep as before)
  def show
    render json: @course
  end

  def create
    # Only guru allowed to create
    unless current_user.role == "guru"
      return render json: { error: "Only guru can create courses" }, status: :forbidden
    end

    @course = current_user.courses.build(course_params)
    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def update
    unless @course.user_id == current_user.id
      return render json: { error: "Unauthorized" }, status: :forbidden
    end

    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    unless @course.user_id == current_user.id
      return render json: { error: "Unauthorized" }, status: :forbidden
    end

    @course.destroy
    head :no_content
  end

  private

  def set_course
    @course = Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Course not found" }, status: :not_found
  end

  def course_params
    params.permit(:title, :description, :thumbnail_url)
  end

  def full_name(user)
    if user.respond_to?(:first_name) && user.respond_to?(:last_name)
      "#{user.first_name} #{user.last_name}".strip
    else
      user.try(:name) || "Unknown"
    end
  end
end