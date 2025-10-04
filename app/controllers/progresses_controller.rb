class ProgressesController < ApplicationController
  before_action :authorize_request

  def index
    progresses = @current_user.progresses.includes(:lesson)
    render json: progresses.to_json(include: :lesson)
  end

  def create
    progress = @current_user.progresses.find_or_initialize_by(lesson_id: params[:lesson_id])
    progress.status = params[:status]
    if progress.save
      render json: progress, status: :created
    else
      render json: { errors: progress.errors.full_messages }, status: :unprocessable_entity
    end
  end
end